# `go-binary-release`

Cross-compile Go binaries and attach to a GitHub Release.

## Overview

- Cross-compile Go binaries for configured GOOS/GOARCH pairs and publish
- them as GitHub Release assets (typically on version tags).

The defaults build with `CGO_ENABLED=0` and `-trimpath -buildvcs=false`, so each
artifact is statically linked and the same commit rebuilds to the same bytes. A
`SHA256SUMS` file is written into the dist directory alongside the binaries with
bare filenames, so a consumer can run `sha256sum -c SHA256SUMS` next to the
downloaded assets. A caller that genuinely needs cgo passes `cgo-enabled: "1"`.

## Call

`actionsforge/actions/.github/workflows/go-binary-release.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/go-binary-release.yml@main
    with:
      binary-name: <value>
      go-version: stable
      working-directory: .
      package: .
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `go-version` | `string` | no | `stable` | Go version for setup-go (e.g. 1.25, stable) |
| `working-directory` | `string` | no | `.` | Directory containing go.mod |
| `binary-name` | `string` | yes | — | Base name for release artifacts (name-goos-goarch) |
| `package` | `string` | no | `.` | Package or main file passed to go build |
| `ldflags` | `string` | no | `-s -w` | Linker flags passed to go build -ldflags |
| `cgo-enabled` | `string` | no | `0` | CGO_ENABLED value for the build; 0 produces a statically linked binary |
| `trimpath` | `boolean` | no | `true` | Strip build host paths and the VCS stamp for a reproducible binary |
| `checksums` | `boolean` | no | `true` | Write SHA256SUMS covering the built artifacts |
| `platforms` | `string` | no | see workflow default | Newline-separated GOOS/GOARCH pairs |
| `dist-dir` | `string` | no | `dist` | Output directory for built binaries |
| `create-release` | `boolean` | no | `true` | Create or update a GitHub Release and upload assets |
| `generate-release-notes` | `boolean` | no | `true` | Autogenerate GitHub Release notes |
| `draft` | `boolean` | no | `false` | Create the release as a draft |
| `prerelease` | `boolean` | no | `false` | Mark the release as a prerelease |
| `cache` | `boolean` | no | `true` | Enable setup-go module cache |

