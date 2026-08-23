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
  workflows: write # required when Dependabot edits .github/workflows/*

jobs:
  call:
    uses: actionsforge/actions/.github/workflows/dependabot-auto-merge.yml@main
    secrets: inherit
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

## Notes

- Enable **Allow auto-merge** on the repo and configure branch protection/rulesets for `gh pr merge --auto`.
- Callers must grant `workflows: write` (in addition to the reusable) so Dependabot PRs that edit `.github/workflows/*` can merge with `GITHUB_TOKEN`.

