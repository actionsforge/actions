# `terraform-drift`

Scheduled terraform plan; open an issue (and outputs) on drift.

## Call

`actionsforge/actions/.github/workflows/terraform-drift.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/terraform-drift.yml@main
    with:
      working-directory: .
      environment-label: prod
    secrets:
      AWS_ACCOUNT_ID: ${{ secrets.AWS_ACCOUNT_ID }}
      # VERCEL_API_TOKEN: ${{ secrets.VERCEL_API_TOKEN }}  # optional TF_VAR
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `working-directory` | `string` | no | `.` | Path to the Terraform configuration directory |
| `environment-label` | `string` | no | `(empty)` | Optional label included in the drift issue title (e.g. env name) |
| `aws-region` | `string` | no | `(empty)` | AWS region for OIDC (defaults to vars.AWS_REGION) |
| `terraform-version` | `string` | no | `(empty)` | Terraform version (defaults to vars.TERRAFORM_VERSION) |
| `init-upgrade` | `boolean` | no | `false` | Run terraform init -upgrade |
| `create-issue` | `boolean` | no | `true` | Open a GitHub issue when drift is detected |
| `issue-labels` | `string` | no | `terraform,drift` | Comma-separated labels for the drift issue |

## Secrets

| Name | Required | Description |
| --- | --- | --- |
| `AWS_ACCOUNT_ID` | yes | AWS account id for the OIDC role ARN |
| `VERCEL_API_TOKEN` | no | Optional TF_VAR_vercel_api_token |
| `VERCEL_GITHUB_PAT` | no | Optional TF_VAR_github_pat |
| `SANDBOX_ACCOUNT_EMAIL` | no | Optional TF_VAR_sandbox_account_email |
| `DEV_ACCOUNT_EMAIL` | no | Optional TF_VAR_dev_account_email |
| `NETWORK_ACCOUNT_EMAIL` | no | Optional TF_VAR_network_account_email |
| `SHARED_SERVICES_ACCOUNT_EMAIL` | no | Optional TF_VAR_shared_services_account_email |

Pass secrets **explicitly** when the caller and this repo are in different orgs (`secrets: inherit` does not cross organizations).

## Outputs

| Name | Description |
| --- | --- |
| `has_changes` | Whether terraform plan reported changes |
| `has_errors` | Whether terraform plan exited non-zero |
| `plan_summary` | Short plan summary line (e.g. Plan: 0 to add, 0 to change) |
| `environment_label` | Echo of environment-label input |

## Notes

- Pass secrets **explicitly** (do not use `secrets: inherit` across orgs).
- Only `AWS_ACCOUNT_ID` is required; other secrets are optional `TF_VAR_*` pass-through.
- For Slack, call [`notify-slack`](./notify-slack.md) when `outputs.has_changes == 'true'`.
- Caller variables: `OIDC_ROLE_NAME`, `AWS_REGION`, `TERRAFORM_VERSION`.

## Expected caller variables

| Variable | Purpose |
| --- | --- |
| `OIDC_ROLE_NAME` | IAM role name used in the OIDC assume-role ARN |
| `AWS_REGION` | Used when `aws-region` input is empty |
| `TERRAFORM_VERSION` | Used when `terraform-version` input is empty |

