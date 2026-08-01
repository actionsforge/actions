# `node-action-tag-and-release`

Semver tag + release for Node-based GitHub Actions.

## Overview

- Semver tag + GitHub Release for Node/JS GitHub Actions.
- Bumps patch (with minor/major rollover at .99), force-updates floating vMAJOR,
- and optionally builds + commits dist/ before tagging.

## Call

`actionsforge/actions/.github/workflows/node-action-tag-and-release.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/node-action-tag-and-release.yml@main
    with:
      node-version: 20
      build: true
      commit-dist: false
      create-release: true
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `node-version` | `string` | no | `20` | Node.js version |
| `build` | `boolean` | no | `true` | Run npm run build after install |
| `commit-dist` | `boolean` | no | `false` | Commit and push dist/ changes before tagging |
| `create-release` | `boolean` | no | `true` | Create a GitHub Release for the new tag |
| `update-major-tag` | `boolean` | no | `true` | Force-update floating vMAJOR tag to the new release |

