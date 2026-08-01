# `docker-image-release`

Build/push GHCR tags and optionally create a GitHub Release.

## Overview

- Build/push a GHCR image (semver + sha + latest) and create a GitHub Release on tags.
- Distinct from docker-image-publish (scan/ECR-focused): this matches platformfuzz
- *-image build-and-release.yml (push + softprops GH release, no Trivy).

## Call

`actionsforge/actions/.github/workflows/docker-image-release.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/docker-image-release.yml@main
    with:
      dockerfile: Dockerfile
      context: .
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `image-name` | `string` | no | `(empty)` | Image name without registry (defaults to github.repository) |
| `image-suffix` | `string` | no | `(empty)` | Optional suffix appended to the image name (e.g. -test) |
| `dockerfile` | `string` | no | `Dockerfile` | Path to the Dockerfile |
| `context` | `string` | no | `.` | Docker build context |
| `build-args` | `string` | no | `(empty)` | Docker build-args (multiline KEY=value), optional |
| `platforms` | `string` | no | `linux/amd64` | Target platforms for the build |
| `create-release` | `boolean` | no | `true` | Create a GitHub Release when the ref is a tag |
| `generate-release-notes` | `boolean` | no | `true` | Autogenerate GitHub Release notes |

