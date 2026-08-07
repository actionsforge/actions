# `gatekeeper-validate`

Discover app Kustomize overlays, expand CronJob/Deployment/Job pod templates, and run `gator test` against a Gatekeeper policy tree.

## Call

`actionsforge/actions/.github/workflows/gatekeeper-validate.yml@main`

## Example (public k8sforge policies)

```yaml
name: Gatekeeper validate
on:
  pull_request:
    paths:
      - "apps/**"
      - ".github/workflows/gatekeeper-validate.yml"
permissions:
  contents: read
jobs:
  gator-test:
    uses: actionsforge/actions/.github/workflows/gatekeeper-validate.yml@main
    with:
      apps-path: apps
      policy-repo: k8sforge/gatekeeper-policies
      policy-ref: main
      policy-path: policies/enforce
```

Use `policies/enforce` when `deny-only` is true (default). Dryrun-only packs are ignored by `--deny-only`.

## Example (policies in the caller repo)

```yaml
jobs:
  gator-test:
    uses: actionsforge/actions/.github/workflows/gatekeeper-validate.yml@main
    with:
      apps-path: apps
      policy-path: policies/base
```

## Example (private policy repo)

```yaml
jobs:
  gator-test:
    uses: actionsforge/actions/.github/workflows/gatekeeper-validate.yml@main
    with:
      policy-repo: my-org/private-policies
      policy-ref: main
      policy-path: policies/overlays/{cluster}
      policy-path-fallback: policies/base
    secrets:
      POLICY_REPO_TOKEN: ${{ secrets.POLICY_REPO_TOKEN }}
```

Pass secrets explicitly across organizations (do not rely on `secrets: inherit`).

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `apps-path` | string | no | `apps` | Root to discover overlays |
| `policy-repo` | string | no | `""` | Optional `owner/name` GitHub repo with policies |
| `policy-ref` | string | no | `main` | Git ref for `policy-repo` |
| `policy-checkout-path` | string | no | `policy-src` | Checkout directory for `policy-repo` |
| `policy-path` | string | no | `policies` | Policy path relative to policy workspace; optional `{cluster}` |
| `policy-path-fallback` | string | no | `""` | Fallback path if primary missing |
| `deny-only` | boolean | no | `true` | Pass `--deny-only` to gator |
| `skip-overlay-name-suffix` | string | no | `.old` | Skip cluster dirs with this suffix |
| `gator-version` | string | no | `3.22.0` | gator release |
| `gator-sha256` | string | no | (pinned) | linux-amd64 tarball SHA-256 |
| `kustomize-version` | string | no | `5.8.1` | kustomize release |
| `kustomize-sha256` | string | no | (pinned) | linux-amd64 tarball SHA-256 |
| `pyyaml-version` | string | no | `6.0.2` | PyYAML pin for expand-pods |
| `actionsforge-ref` | string | no | `main` | Ref of `actionsforge/actions` for `scripts/gatekeeper` (pin to the same commit as the workflow `uses:` when needed) |

## Secrets

| Name | Required | Description |
| --- | --- | --- |
| `POLICY_REPO_TOKEN` | no | Read token for a private `policy-repo` |

## Notes

- This workflow runs **`gator test`** on app manifests. It does not install policies on a cluster and is not **`gator verify`** for Gatekeeper test suites.
- Overlay discovery matches `*/overlays/*/kustomization.yaml` and `*/overlays/*/manifests/kustomization.yaml` (excludes `vendored/`).
- Community alternative: [open-policy-agent/gatekeeper-library](https://github.com/open-policy-agent/gatekeeper-library) (templates under `library/`; you usually still need Constraints).
