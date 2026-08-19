# `zensical-pages-deploy`

Build a Zensical site and deploy to GitHub Pages.

## Call

`actionsforge/actions/.github/workflows/zensical-pages-deploy.yml@main`

## Example

```yaml
# Build on PRs; deploy only on push / workflow_dispatch
jobs:
  pages:
    uses: actionsforge/actions/.github/workflows/zensical-pages-deploy.yml@main
    with:
      python-version: "3.13"
```

For a site whose `zensical.toml` is not at the repository root:

```yaml
jobs:
  pages:
    uses: actionsforge/actions/.github/workflows/zensical-pages-deploy.yml@main
    with:
      working-directory: docs
      destination: site
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `python-version` | `string` | no | `3.13` | Python version for the Zensical build |
| `working-directory` | `string` | no | `.` | Directory that contains `zensical.toml` |
| `requirements-file` | `string` | no | `requirements.txt` | Pip requirements file relative to `working-directory` |
| `destination` | `string` | no | `site` | Zensical output directory (Pages artifact path) |
| `build-args` | `string` | no | `--clean` | Extra arguments passed to `zensical build` |
| `artifact-name` | `string` | no | `github-pages` | Name of the Pages artifact to upload and deploy |
| `retention-days` | `string` | no | `1` | Number of days to retain the uploaded artifact |
| `deploy` | `boolean` | no | `true` | Deploy to GitHub Pages (also skipped on `pull_request`) |

## Notes

- On `pull_request`, the build still runs and uploads an artifact; deploy is skipped unless you call outside a PR (and `deploy` is `true`).
- GitHub Pages for the caller repository must use **GitHub Actions** as the source.
- Install is `pip install -r` on `requirements-file`. Include `zensical` and any theme (for example `zensical-patina`) there.
