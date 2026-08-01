# `chart-releaser`

Package and release Helm charts with chart-releaser.

## Call

`actionsforge/actions/.github/workflows/chart-releaser.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/chart-releaser.yml@main
    with:
      charts_dir: charts
    secrets:
      cr_token: ${{ secrets.cr_token }}
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `charts_dir` | `string` | no | `charts` | Directory containing Helm charts (e.g., 'charts' or '.') |

## Secrets

| Name | Required | Description |
| --- | --- | --- |
| `cr_token` | yes |  |

Pass secrets **explicitly** when the caller and this repo are in different orgs (`secrets: inherit` does not cross organizations).

