# `kustomize-build`

Discover Kustomize roots under caller-defined paths and run `kustomize build` on each one. Reports every failing root, not just the first, and writes a pass/fail table to the job summary.

## Call

`actionsforge/actions/.github/workflows/kustomize-build.yml@main`

`roots` and `patterns` are required: this workflow assumes nothing about your layout.

## Example (Argo CD base/overlay apps)

```yaml
name: Kustomize build
on:
  pull_request:
    paths:
      - "apps/**"
      - ".github/workflows/kustomize-build.yml"
permissions:
  contents: read
jobs:
  build:
    uses: actionsforge/actions/.github/workflows/kustomize-build.yml@main
    with:
      job-name: kustomize build (apps)
      roots: apps
      patterns: |
        */base/kustomization.yaml
        */base/manifests/kustomization.yaml
        */overlays/*/kustomization.yaml
        */overlays/*/manifests/kustomization.yaml
      exclude-patterns: |
        */vendored/*
```

Overlays already pull in their bases, but building bases explicitly still catches mistakes in shared trees when a PR only touches base files.

## Example (multiple roots and extra patterns)

```yaml
jobs:
  build:
    uses: actionsforge/actions/.github/workflows/kustomize-build.yml@main
    with:
      roots: infrastructure shared
      patterns: |
        */base/kustomization.yaml
        */overlays/*/kustomization.yaml
        */policies/base/kustomization.yaml
        */policies/overlays/*/kustomization.yaml
      exclude-patterns: |
        */vendored/*
      kustomize-args: --enable-helm
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `roots` | string | yes | - | Space-separated directories to search (`find` start points) |
| `patterns` | string | yes | - | Newline-separated `find -path` globs identifying kustomization files |
| `exclude-patterns` | string | no | `""` | Newline-separated `find -path` globs to exclude |
| `kustomize-args` | string | no | `""` | Extra args appended to each `kustomize build` |
| `fail-fast` | boolean | no | `false` | Stop at the first failing root instead of reporting every failure |
| `allow-empty` | boolean | no | `false` | Succeed when no kustomization files match |
| `job-name` | string | no | `kustomize build` | Job display name (appears in the check name) |
| `runs-on` | string | no | `ubuntu-latest` | Runner label |
| `kustomize-version` | string | no | `5.8.1` | kustomize release to install |
| `kustomize-sha256` | string | no | `""` | Tarball SHA-256 for this runner's OS/arch; empty verifies via the release `checksums.txt` |

No secrets or outputs.

## Notes

- **Patterns are matched against full paths under `roots`**, so `*/base/kustomization.yaml` matches `apps/my-app/base/kustomization.yaml`. Exclusions apply to the same paths (`*/vendored/*` needs a path segment named exactly `vendored`).
- **The download is always verified.** With `kustomize-sha256` set you get a hard pin; left empty, the tarball is checked against the `checksums.txt` published with that release, so version bumps and non-amd64 runners need no hand-maintained hashes.
- **No `sudo`.** kustomize is installed into `$RUNNER_TEMP` and added via `$GITHUB_PATH`, so self-hosted runners without passwordless sudo work. Architecture is detected from `uname -m` (amd64, arm64, ppc64le, s390x).
- **Self-contained.** The build loop is inline in the workflow rather than fetched from a script in this repo, so pinning `uses: ...@<sha>` pins every line that executes.
- A failing root prints kustomize's stderr beneath its `FAIL` line; rendered manifests are discarded.
