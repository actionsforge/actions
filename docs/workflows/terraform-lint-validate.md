# `terraform-lint-validate`

terraform fmt/validate (and related checks).

## Call

`actionsforge/actions/.github/workflows/terraform-lint-validate.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/terraform-lint-validate.yml@main
    with:
      path: .
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `path` | `string` | no | `.` | Path to the Terraform configuration directory |

