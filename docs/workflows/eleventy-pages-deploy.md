# `eleventy-pages-deploy`

Build an Eleventy site and deploy to GitHub Pages.

## Call

`actionsforge/actions/.github/workflows/eleventy-pages-deploy.yml@main`

## Example

```yaml
# Build on PRs; deploy only on push / workflow_dispatch
jobs:
  pages:
    uses: actionsforge/actions/.github/workflows/eleventy-pages-deploy.yml@main
    with:
      node-version: "24"
      path-prefix: /my-repo/
```

For a site whose `package.json` is not at the repository root:

```yaml
jobs:
  pages:
    uses: actionsforge/actions/.github/workflows/eleventy-pages-deploy.yml@main
    with:
      working-directory: docs
      destination: _site
      path-prefix: /my-repo/
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `node-version` | `string` | no | `24` | Node.js version for the Eleventy build |
| `working-directory` | `string` | no | `.` | Directory that contains `package.json` |
| `install-command` | `string` | no | `npm ci --no-audit --no-fund` | Shell command to install dependencies |
| `build-command` | `string` | no | `npm run build` | Shell command to build the site |
| `path-prefix` | `string` | no | `/` | Value for `PATH_PREFIX` (Eleventy `pathPrefix`) |
| `destination` | `string` | no | `_site` | Build output directory (Pages artifact path) |
| `artifact-name` | `string` | no | `github-pages` | Name of the Pages artifact to upload and deploy |
| `retention-days` | `string` | no | `1` | Number of days to retain the uploaded artifact |
| `deploy` | `boolean` | no | `true` | Deploy to GitHub Pages (also skipped on `pull_request`) |

## Notes

- On `pull_request`, the build still runs and uploads an artifact; deploy is skipped unless you call outside a PR (and `deploy` is `true`).
- GitHub Pages for the caller repository must use **GitHub Actions** as the source.
- Pass `path-prefix` for project Pages URLs (for example `/class-ab-mini-amp/`). Wire that env into Eleventy via `pathPrefix: process.env.PATH_PREFIX || "/"`.
