#!/usr/bin/env bash
# Install pinned gator + kustomize and PyYAML for Gatekeeper CI.
# Version/SHA pins are the single source of truth for this reusable workflow.
set -euo pipefail

GATOR_VERSION="${GATOR_VERSION:-3.22.0}"
GATOR_LINUX_AMD64_SHA256="${GATOR_LINUX_AMD64_SHA256:-45ba8c54a22261473bddf6f4f18b154058d45b0c64f3e7a67b2fa781f0791800}"
KUSTOMIZE_VERSION="${KUSTOMIZE_VERSION:-5.8.1}"
KUSTOMIZE_LINUX_AMD64_SHA256="${KUSTOMIZE_LINUX_AMD64_SHA256:-029a7f0f4e1932c52a0476cf02a0fd855c0bb85694b82c338fc648dcb53a819d}"
PYYAML_VERSION="${PYYAML_VERSION:-6.0.2}"
DEST_DIR="${1:-/usr/local/bin}"

gator_url="https://github.com/open-policy-agent/gatekeeper/releases/download/v${GATOR_VERSION}/gator-v${GATOR_VERSION}-linux-amd64.tar.gz"
gator_tmp="/tmp/gator-v${GATOR_VERSION}-linux-amd64.tar.gz"
curl -fsSL -o "$gator_tmp" "$gator_url"
echo "${GATOR_LINUX_AMD64_SHA256}  ${gator_tmp}" | sha256sum -c -
sudo tar xzf "$gator_tmp" -C "${DEST_DIR}"
rm -f "$gator_tmp"

kus_url="https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz"
kus_tmp="/tmp/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz"
curl -fsSL -o "$kus_tmp" "$kus_url"
echo "${KUSTOMIZE_LINUX_AMD64_SHA256}  ${kus_tmp}" | sha256sum -c -
sudo tar xzf "$kus_tmp" -C "${DEST_DIR}"
rm -f "$kus_tmp"

python3 -m pip install --user "pyyaml==${PYYAML_VERSION}"

gator version | grep GitVersion
kustomize version
