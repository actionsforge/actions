# `github-pages-deploy`

Upload static files and deploy to GitHub Pages.

## Call

`actionsforge/actions/.github/workflows/github-pages-deploy.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/github-pages-deploy.yml@main
    with:
      path: .
      artifact-name: github-pages
      retention-days: 1
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `path` | `string` | no | `.` | Path to the directory of static files to publish |
| `artifact-name` | `string` | no | `github-pages` | Name of the Pages artifact to upload and deploy |
| `retention-days` | `string` | no | `1` | Number of days to retain the uploaded artifact |

