# `terraform-tag`

Create a Terraform module semver tag (and optional release).

## Call

`actionsforge/actions/.github/workflows/terraform-tag.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/terraform-tag.yml@main
    with:
      create-release: false
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `create-release` | `boolean` | no | `false` | Create a GitHub Release for the new tag |

