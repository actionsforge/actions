# `validate-devschema`

Validate JSON (e.g. devcontainer) against a schema.

## Call

`actionsforge/actions/.github/workflows/validate-devschema.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/validate-devschema.yml@main
    with:
      data: .devcontainer/devcontainer.json
      verbose: false
      python-version: 3.13
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `schema` | `string` | no | see workflow default | Path or URL to the JSON schema. |
| `data` | `string` | no | `.devcontainer/devcontainer.json` | Path or URL to the JSON data. |
| `verbose` | `boolean` | no | `false` | Enable verbose output. |
| `python-version` | `string` | no | `3.13` | Python version to use. Must be one of: 3.9, 3.10, 3.11, 3.12, 3.13  |

