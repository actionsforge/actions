# `python-image-validate`

Python lint/test plus Docker image validate.

## Call

`actionsforge/actions/.github/workflows/python-image-validate.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/python-image-validate.yml@main
    with:
      python-version: 3.13
      working-directory: .
      test-command: pytest tests/ -v
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `python-version` | `string` | no | `3.13` | Python version for lint and test |
| `working-directory` | `string` | no | `.` | Directory containing pyproject.toml |
| `install-command` | `string` | no | see workflow default | Shell command to install Python dependencies |
| `lint-command` | `string` | no | `(empty)` | Optional lint command (skipped when empty) |
| `test-command` | `string` | no | `pytest tests/ -v` | Shell command to run the test suite |
| `image-tag` | `string` | no | `image:validate` | Local tag for the Docker validate build |
| `dockerfile` | `string` | no | `Dockerfile` | Path to the Dockerfile |
| `docker-context` | `string` | no | `.` | Docker build context |
| `docker-platforms` | `string` | no | `linux/amd64` | Target platforms for the Docker validate build |
| `docker-validate-enabled` | `boolean` | no | `true` | Build and scan the Docker image during PR checks |
| `trivy-vuln-type` | `string` | no | `os,library` | Comma-separated vulnerability types for Trivy (os, library) |

