#!/usr/bin/env bash
# Discover app overlays and run gator test against a policy kustomize root.
#
# Env:
#   APPS_PATH                 (default: apps)
#   POLICY_ROOT               workspace that contains POLICY_PATH (caller or policy checkout)
#   POLICY_PATH               relative path; may contain {cluster}
#   POLICY_PATH_FALLBACK      optional fallback path (may contain {cluster})
#   DENY_ONLY                 true|false (default true)
#   SKIP_OVERLAY_NAME_SUFFIX  skip cluster dirs ending with this (default .old)
#   EXPAND_PODS_PY            path to expand-pods.py
#   GITHUB_STEP_SUMMARY       optional
set -euo pipefail

APPS_PATH="${APPS_PATH:-apps}"
POLICY_ROOT="${POLICY_ROOT:?POLICY_ROOT is required}"
POLICY_PATH="${POLICY_PATH:-policies}"
POLICY_PATH_FALLBACK="${POLICY_PATH_FALLBACK:-}"
DENY_ONLY="${DENY_ONLY:-true}"
SKIP_OVERLAY_NAME_SUFFIX="${SKIP_OVERLAY_NAME_SUFFIX:-.old}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXPAND_PODS_PY="${EXPAND_PODS_PY:-$SCRIPT_DIR/expand-pods.py}"

if [[ ! -f "$EXPAND_PODS_PY" ]]; then
  echo "expand-pods script not found: $EXPAND_PODS_PY" >&2
  exit 1
fi
if ! command -v gator >/dev/null || ! command -v kustomize >/dev/null; then
  echo "gator and kustomize must be on PATH" >&2
  exit 1
fi

resolve_policy_dir() {
  local cluster="$1"
  local primary="${POLICY_PATH//\{cluster\}/$cluster}"
  local fallback="${POLICY_PATH_FALLBACK//\{cluster\}/$cluster}"
  local candidate="$POLICY_ROOT/$primary"
  if [[ -d "$candidate" ]]; then
    echo "$candidate"
    return 0
  fi
  if [[ -n "$POLICY_PATH_FALLBACK" ]]; then
    candidate="$POLICY_ROOT/$fallback"
    if [[ -d "$candidate" ]]; then
      echo "$candidate"
      return 0
    fi
  fi
  echo "policy path not found for cluster=${cluster:-none}: tried $POLICY_ROOT/$primary" >&2
  if [[ -n "$POLICY_PATH_FALLBACK" ]]; then
    echo "  and fallback $POLICY_ROOT/$fallback" >&2
  fi
  return 1
}

build_policies() {
  local policy_dir="$1"
  local out="$2"
  if [[ -f "$policy_dir/kustomization.yaml" || -f "$policy_dir/kustomization.yml" ]]; then
    kustomize build "$policy_dir" >"$out"
  else
    # Concatenate YAML files for non-kustomize dirs
    : >"$out"
    local f
    for f in "$policy_dir"/*.yaml "$policy_dir"/*.yml; do
      [[ -f "$f" ]] || continue
      printf '\n---\n' >>"$out"
      cat "$f" >>"$out"
    done
  fi
}

mapfile -t overlays < <(find "$APPS_PATH" -type f \( \
  \( -path '*/overlays/*/kustomization.yaml' ! -path '*/vendored/*' \) -o \
  \( -path '*/overlays/*/manifests/kustomization.yaml' ! -path '*/vendored/*' \) \
\) | sort -u)

if [[ "${#overlays[@]}" -eq 0 ]]; then
  echo "No overlays found under ${APPS_PATH}/." >&2
  exit 1
fi

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
declare -A policy_cache=()
failed=0
pass=0
summary=()

gator_args=(test)
if [[ "$DENY_ONLY" == "true" ]]; then
  gator_args+=(--deny-only)
fi

for k in "${overlays[@]}"; do
  d="$(dirname "$k")"
  cluster="$(sed -n 's|.*/overlays/\([^/]*\).*|\1|p' <<<"$d" | head -1)"
  if [[ -n "$SKIP_OVERLAY_NAME_SUFFIX" && "$cluster" == *"$SKIP_OVERLAY_NAME_SUFFIX" ]]; then
    echo "SKIP $d (suffix $SKIP_OVERLAY_NAME_SUFFIX)"
    continue
  fi

  if ! policy_dir="$(resolve_policy_dir "$cluster")"; then
    failed=1
    summary+=("FAIL $d (policy path missing)")
    continue
  fi

  cache_key="$policy_dir"
  policy_file="$work/policies-$(echo "$cache_key" | sha256sum | awk '{print $1}').yaml"
  if [[ -z "${policy_cache[$cache_key]+x}" ]]; then
    build_policies "$policy_dir" "$policy_file"
    policy_cache[$cache_key]=1
  fi

  manifests_file="$work/manifests-$(echo "$d" | sha256sum | awk '{print $1}').yaml"
  kustomize build "$d" | python3 "$EXPAND_PODS_PY" >"$manifests_file"

  if output=$(gator "${gator_args[@]}" -f "$policy_file" -f "$manifests_file" </dev/null 2>&1); then
    echo "PASS $d (policies: $policy_dir)"
    summary+=("PASS $d")
    pass=$((pass + 1))
  else
    echo "FAIL $d (policies: $policy_dir)"
    echo "$output"
    summary+=("FAIL $d")
    failed=1
  fi
done

if [[ -n "${GITHUB_STEP_SUMMARY:-}" ]]; then
  {
    echo "## Gatekeeper validate"
    echo ""
    echo "| Result | Overlay |"
    echo "| --- | --- |"
    for line in "${summary[@]}"; do
      status="${line%% *}"
      rest="${line#* }"
      echo "| $status | \`$rest\` |"
    done
  } >>"$GITHUB_STEP_SUMMARY"
fi

if [[ "$failed" -ne 0 ]]; then
  echo "One or more overlays have policy violations." >&2
  exit 1
fi
if [[ "$pass" -eq 0 ]]; then
  echo "No overlays were tested (all skipped?)." >&2
  exit 1
fi
echo "All overlays passed ($pass roots)."
