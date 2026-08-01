# `docker-image-publish`

Build/push to GHCR or ECR (optional Trivy).

## Call

`actionsforge/actions/.github/workflows/docker-image-publish.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/docker-image-publish.yml@main
    with:
      registry-type: ghcr
      dockerfile: Dockerfile
      context: .
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `registry-type` | `string` | no | `ghcr` | Container registry target (ghcr or ecr) |
| `image-name` | `string` | no | `(empty)` | Image name without registry (defaults to github.repository) |
| `dockerfile` | `string` | no | `Dockerfile` | Path to the Dockerfile |
| `context` | `string` | no | `.` | Docker build context |
| `platforms` | `string` | no | `linux/amd64` | Target platforms for the build |
| `aws-region` | `string` | no | `ap-southeast-2` | AWS region for ECR (registry-type=ecr only) |
| `ecr-repository` | `string` | no | `(empty)` | ECR repository name (registry-type=ecr only) |
| `scan-enabled` | `boolean` | no | `true` | Run Trivy before push |
| `trivy-severity` | `string` | no | `CRITICAL` | Comma-separated severities that fail the scan |
| `trivy-ignore-unfixed` | `boolean` | no | `false` | Ignore unfixed vulnerabilities in Trivy |

## Secrets

| Name | Required | Description |
| --- | --- | --- |
| `aws-role-arn` | no | IAM role ARN for OIDC ECR push (registry-type=ecr only) |

Pass secrets **explicitly** when the caller and this repo are in different orgs (`secrets: inherit` does not cross organizations).

