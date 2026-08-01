# `bitwarden-get-secret`

Fetch one Bitwarden SM secret into a job output.

## Call

`actionsforge/actions/.github/workflows/bitwarden-get-secret.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/bitwarden-get-secret.yml@main
    with:
      secret-id-secret: BW_SECRET_ID
      env-name: SECRET_VALUE
      base-url: "https://vault.bitwarden.com"
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `secret-id-secret` | `string` | no | `BW_SECRET_ID` | GitHub secret name that holds the Bitwarden secret UUID |
| `env-name` | `string` | no | `SECRET_VALUE` | Name used when exporting the fetched value from sm-action |
| `base-url` | `string` | no | `https://vault.bitwarden.com` | Bitwarden Secrets Manager API base URL |

## Outputs

| Name | Description |
| --- | --- |
| `value` | Fetched secret value (masked) |

## Notes

- Uses caller secrets: `BW_ACCESS_TOKEN` and a secret named by `secret-id-secret` (default `BW_SECRET_ID`).

