# `markdown-lint`

Lint Markdown with markdownlint-cli.

## Call

`actionsforge/actions/.github/workflows/markdown-lint.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/markdown-lint.yml@main
    with:
      ignore: node_modules
      node-version: 20
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `config` | `string` | no | see workflow default | a markdownlint compatible JSON object string  |
| `ignore` | `string` | no | `node_modules` | a space separated list of directories and files to ignore  |
| `node-version` | `string` | no | `20` | Node.js version used to install markdownlint-cli |

