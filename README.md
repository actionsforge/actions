# actions

Reusable GitHub Actions **workflows** for actionsforge (and callers in other orgs).

## Quick start

```yaml
name: Markdown Lint

on:
  pull_request: {}

permissions:
  statuses: write
  checks: write
  contents: read
  pull-requests: read

jobs:
  markdown-lint:
    uses: actionsforge/actions/.github/workflows/markdown-lint.yml@main
```

Full catalog, parameters, and examples: **[docs/README.md](./docs/README.md)**.

## Common patterns

### Required hygiene pair

Most maintained repos call these on every PR:

| Workflow | Doc |
| --- | --- |
| `markdown-lint` | [docs](./docs/workflows/markdown-lint.md) |
| `commitmsg-conform` | [docs](./docs/workflows/commitmsg-conform.md) |

### Secrets across organizations

When the caller repo is **not** in `actionsforge`, do **not** rely on `secrets: inherit`.
Declare secrets on `workflow_call` and pass them explicitly (see
[terraform-drift](./docs/workflows/terraform-drift.md),
[notify-slack](./docs/workflows/notify-slack.md),
[gh-teams-sync](./docs/workflows/gh-teams-sync.md)).

### Pinning

```yaml
uses: actionsforge/actions/.github/workflows/docker-image-validate.yml@main
# or
uses: actionsforge/actions/.github/workflows/docker-image-validate.yml@<commit-sha>
```

## Workflow index

See **[docs/README.md](./docs/README.md)** for the full list grouped by category.
