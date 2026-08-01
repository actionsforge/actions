# `go-mod-tidy-build`

go mod tidy check and build.

## Overview

- Verify go.mod/go.sum are tidy and optionally compile packages.
- Intended for Go service/CLI CI before image build or release.

## Call

`actionsforge/actions/.github/workflows/go-mod-tidy-build.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/go-mod-tidy-build.yml@main
    with:
      go-version: stable
      working-directory: .
      tidy: true
      build: true
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `go-version` | `string` | no | `stable` | Go version for setup-go (e.g. 1.25, stable) |
| `working-directory` | `string` | no | `.` | Directory containing go.mod |
| `tidy` | `boolean` | no | `true` | Run go mod tidy and fail if go.mod/go.sum change |
| `build` | `boolean` | no | `true` | Run a go build after tidy |
| `build-command` | `string` | no | `go build -v ./...` | Build command (used when build is true) |
| `cache` | `boolean` | no | `true` | Enable setup-go module cache |

