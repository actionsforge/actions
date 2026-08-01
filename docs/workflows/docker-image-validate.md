# `docker-image-validate`

Build a Docker image and optionally scan with Trivy.

## Call

`actionsforge/actions/.github/workflows/docker-image-validate.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/docker-image-validate.yml@main
    with:
      image-tag: "image:validate"
      dockerfile: Dockerfile
      context: .
      platforms: linux/amd64
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `image-tag` | `string` | no | `image:validate` | Local tag for the built image |
| `dockerfile` | `string` | no | `Dockerfile` | Path to the Dockerfile |
| `context` | `string` | no | `.` | Docker build context |
| `platforms` | `string` | no | `linux/amd64` | Target platforms for the build |
| `scan-enabled` | `boolean` | no | `true` | Run Trivy vulnerability scan on the built image |
| `trivy-severity` | `string` | no | `CRITICAL,HIGH` | Comma-separated severities to report |
| `trivy-exit-code` | `string` | no | `1` | Exit code when vulnerabilities are found at or above trivy-severity |
| `trivy-ignore-unfixed` | `boolean` | no | `false` | Ignore unfixed vulnerabilities in Trivy |
| `trivy-vuln-type` | `string` | no | `os,library` | Comma-separated vulnerability types for Trivy (os, library) |

