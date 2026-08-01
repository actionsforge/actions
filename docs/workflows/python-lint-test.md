# `python-lint-test`

Install, lint, and test a Python project.

## Call

`actionsforge/actions/.github/workflows/python-lint-test.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/python-lint-test.yml@main
    with:
      python-version: 3.13
      working-directory: .
      test-command: pytest tests/ -v
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `python-version` | `string` | no | `3.13` | Python version for lint and test |
| `working-directory` | `string` | no | `.` | Directory containing pyproject.toml |
| `install-command` | `string` | no | see workflow default | Shell command to install dependencies |
| `lint-command` | `string` | no | `(empty)` | Optional lint command (skipped when empty) |
| `test-command` | `string` | no | `pytest tests/ -v` | Shell command to run the test suite |

