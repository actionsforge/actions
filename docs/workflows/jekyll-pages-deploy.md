# `jekyll-pages-deploy`

Build a Jekyll site and deploy to GitHub Pages.

## Call

`actionsforge/actions/.github/workflows/jekyll-pages-deploy.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/jekyll-pages-deploy.yml@main
    with:
      source: ./
      destination: ./_site
      artifact-name: github-pages
      retention-days: 1
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `source` | `string` | no | `./` | Directory where the Jekyll source files reside |
| `destination` | `string` | no | `./_site` | Jekyll build output directory (uploaded as the Pages artifact) |
| `artifact-name` | `string` | no | `github-pages` | Name of the Pages artifact to upload and deploy |
| `retention-days` | `string` | no | `1` | Number of days to retain the uploaded artifact |

