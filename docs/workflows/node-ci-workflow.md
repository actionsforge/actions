# `node-ci-workflow`

Install, test, and optionally build/audit a Node project.

## Overview

- Generic Node.js CI: install → optional typecheck → test → optional build → optional audit.
- Repo-specific test env (tokens, users, etc.) belongs in the project's test setup
- (e.g. vitest setupFiles / jest setupFiles), not in this reusable.

## Call

`actionsforge/actions/.github/workflows/node-ci-workflow.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/node-ci-workflow.yml@main
    with:
      node-version: 20
      working-directory: .
      install-command: npm ci --no-audit --no-fund
      typecheck: false
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `node-version` | `string` | no | `20` | Node.js version |
| `working-directory` | `string` | no | `.` | Directory containing package.json / lockfile |
| `install-command` | `string` | no | `npm ci --no-audit --no-fund` | Shell command to install dependencies |
| `typecheck` | `boolean` | no | `false` | Run npm run typecheck before tests |
| `typecheck-command` | `string` | no | `npm run typecheck` | Typecheck command (used when typecheck is true) |
| `test-command` | `string` | no | `npm test` | Test command (coverage flag appended when coverage is true) |
| `coverage` | `boolean` | no | `false` | Append --coverage to test-command |
| `build` | `boolean` | no | `true` | Run build after tests |
| `build-command` | `string` | no | `npm run build` | Build command (used when build is true) |
| `audit` | `boolean` | no | `false` | Run npm audit --audit-level=high after build |
| `audit-command` | `string` | no | `npm audit --audit-level=high` | Audit command (used when audit is true) |

