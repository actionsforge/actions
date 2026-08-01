# `gh-teams-sync`

Sync org teams from a YAML file.

## Overview

- Sync GitHub org teams from a declarative YAML file via
- actionsforge/actions-gh-teams-sync. Callers must pass GH_ORG_TOKEN
- explicitly (secrets: inherit is unreliable across organizations).

## Call

`actionsforge/actions/.github/workflows/gh-teams-sync.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/gh-teams-sync.yml@main
    with:
      config-path: teams.yaml
      dry-run: false
    secrets:
      GH_ORG_TOKEN: ${{ secrets.GH_ORG_TOKEN }}
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `config-path` | `string` | no | `teams.yaml` | Path to the teams YAML config |
| `dry-run` | `boolean` | no | `false` | Run without making changes |

## Secrets

| Name | Required | Description |
| --- | --- | --- |
| `GH_ORG_TOKEN` | yes | PAT with admin:org (and repo) for team membership sync |

Pass secrets **explicitly** when the caller and this repo are in different orgs (`secrets: inherit` does not cross organizations).

