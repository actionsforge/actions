# `chart-lint-validate`

Helm chart-testing lint/install.

## Call

`actionsforge/actions/.github/workflows/chart-lint-validate.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/chart-lint-validate.yml@main
    with:
      chart_dirs: charts
      target_branch: ""
      helm_version: latest
      python_version: 3.x
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `chart_dirs` | `string` | no | `charts` | Chart directory relative to repository root (passed to ct --chart-dirs) |
| `target_branch` | `string` | no | `(empty)` | Target branch for chart-testing (defaults to repository default branch) |
| `helm_version` | `string` | no | `latest` | Helm version (e.g., 3.15.4 or latest) |
| `python_version` | `string` | no | `3.x` | Python version for chart-testing |
| `run_lint` | `boolean` | no | `true` | Run chart lint validation |
| `run_install` | `boolean` | no | `true` | Run chart install validation |

