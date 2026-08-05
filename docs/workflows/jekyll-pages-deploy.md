# `jekyll-pages-deploy`

Build a Jekyll site and deploy to GitHub Pages.

## Call

`actionsforge/actions/.github/workflows/jekyll-pages-deploy.yml@main`

## Example

```yaml
# Build on PRs; deploy only on push / workflow_dispatch
jobs:
  pages:
    uses: actionsforge/actions/.github/workflows/jekyll-pages-deploy.yml@main
    with:
      source: docs
      destination: docs/_site
      ruby-version: "3.3"
```

For a default GitHub Pages / `jekyll-build-pages` site (no custom Gemfile Ruby):

```yaml
jobs:
  pages:
    uses: actionsforge/actions/.github/workflows/jekyll-pages-deploy.yml@main
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `source` | `string` | no | `./` | Directory where the Jekyll source files reside |
| `destination` | `string` | no | `./_site` | Jekyll build output directory (uploaded as the Pages artifact) |
| `artifact-name` | `string` | no | `github-pages` | Name of the Pages artifact to upload and deploy |
| `retention-days` | `string` | no | `1` | Number of days to retain the uploaded artifact |
| `deploy` | `boolean` | no | `true` | Deploy to GitHub Pages (also skipped on `pull_request`) |
| `ruby-version` | `string` | no | `(empty)` | Ruby for Gemfile/bundler build; empty uses `actions/jekyll-build-pages` |

## Notes

- On `pull_request`, the build still runs and uploads an artifact; deploy is skipped unless you somehow call outside a PR (and `deploy` is `true`).
- Set `ruby-version` (e.g. `3.3`) for sites with a custom `Gemfile` (just-the-docs, Jekyll 4.x, etc.).
- Leave `ruby-version` empty to keep the GitHub Pages–compatible `jekyll-build-pages` builder.
