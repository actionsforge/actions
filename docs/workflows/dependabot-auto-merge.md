# `dependabot-auto-merge`

Enable GitHub auto-merge for Dependabot PRs.

## Call

`actionsforge/actions/.github/workflows/dependabot-auto-merge.yml@main`

## Example

```yaml
permissions:
  contents: write
  pull-requests: write
  checks: read

jobs:
  call:
    uses: actionsforge/actions/.github/workflows/dependabot-auto-merge.yml@main
    # Explicit map: Dependabot pull_request runs do not get Actions secrets via
    # secrets: inherit — only Dependabot secrets, evaluated in the caller.
    secrets:
      DEPENDABOT_MERGE_APP_ID: ${{ secrets.DEPENDABOT_MERGE_APP_ID }}
      DEPENDABOT_MERGE_APP_PRIVATE_KEY: ${{ secrets.DEPENDABOT_MERGE_APP_PRIVATE_KEY }}
    with:
      target: any
      merge-method: squash
      use-github-auto-merge: true
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `target` | `string` | no | `any` | SemVer auto-merge ceiling (major, minor, patch, any) |
| `merge-method` | `string` | no | `squash` | Merge method (squash, merge, rebase) |
| `use-github-auto-merge` | `boolean` | no | `true` | Enable GitHub auto-merge instead of merging immediately |
| `skip-verification` | `boolean` | no | `false` | Skip Dependabot user/commit verification (unused; kept for callers) |
| `approve-only` | `boolean` | no | `false` | Only approve the PR without merging (unsupported without Actions approve permission) |
| `exclude` | `string` | no | `(empty)` | Comma-separated packages to exclude from auto-merge |

## Secrets (optional)

Pass via `secrets: inherit` (or explicitly) when Dependabot PRs edit `.github/workflows/*`.
`GITHUB_TOKEN` cannot merge those PRs; a GitHub App with **Workflows: Read and write** can.

| Secret | Description |
| --- | --- |
| `DEPENDABOT_MERGE_APP_ID` | App ID for [actionsforge-dependabot-merge](https://github.com/apps/actionsforge-dependabot-merge) |
| `DEPENDABOT_MERGE_APP_PRIVATE_KEY` | PEM private key for that App |

Install the App only on repos that need it. When these secrets are absent, the workflow falls back to `GITHUB_TOKEN` (non-workflow Dependabot PRs still merge).

Dependabot-triggered `pull_request` runs only see **Dependabot secrets**, not Actions secrets. Store the same names under
**Settings → Secrets and variables → Dependabot** (and optionally also as Actions secrets for other triggers).

## Notes

- Enable **Allow auto-merge** on the repo and configure branch protection/rulesets for `gh pr merge --auto`.
- Do **not** add `workflows: write` to caller or reusable `permissions` — GitHub rejects it (`Unexpected value 'workflows'`).
- Without the App secrets, PRs that only bump Actions pins inside workflow files will fail or skip at merge time; that is a GitHub platform limit on `GITHUB_TOKEN`.
