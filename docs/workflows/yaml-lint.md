# `yaml-lint`

Lint YAML with yamllint.

## Call

`actionsforge/actions/.github/workflows/yaml-lint.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/yaml-lint.yml@main
    with:
      yamllint_file_or_dir: .
      yamllint_config_filepath: .yamllint
      yamllint_format: github
      yamllint_strict: false
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `yamllint_file_or_dir` | `string` | no | `.` | File or directory to lint (defaults to repository root) |
| `yamllint_config_filepath` | `string` | no | `.yamllint` | Path to yamllint configuration file |
| `yamllint_format` | `string` | no | `github` | Output format for yamllint (github, standard, etc.) |
| `yamllint_strict` | `boolean` | no | `false` | Enable strict mode for yamllint |

