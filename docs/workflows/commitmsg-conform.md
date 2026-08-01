# `commitmsg-conform`

Enforce conventional commit messages (skips Dependabot).

## Call

`actionsforge/actions/.github/workflows/commitmsg-conform.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/commitmsg-conform.yml@main
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `config` | `string` | no | see workflow default | Inline Conform YAML used when the caller has no `.conform.yaml` |

## Notes

- Skips when `github.actor` is Dependabot (`dependabot[bot]` / `dependabot-preview[bot]`).
- Default policy requires a conventional commit **body** (blank line + description).
- If the caller repo already has `.conform.yaml`, that file is used and the `config` input is ignored.

