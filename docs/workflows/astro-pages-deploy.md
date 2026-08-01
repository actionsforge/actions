# `astro-pages-deploy`

Build an Astro site and deploy to GitHub Pages.

## Call

`actionsforge/actions/.github/workflows/astro-pages-deploy.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/astro-pages-deploy.yml@main
    with:
      node-version: 22
      path: .
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `node-version` | `string` | no | `22` | Node.js version for the Astro build |
| `path` | `string` | no | `.` | Path to the Astro project root |
| `validate-command` | `string` | no | `(empty)` | Optional command after npm ci (e.g. npm run validate) |
| `test-command` | `string` | no | `(empty)` | Optional command after npm ci (e.g. npm run test) |

