# `terraform-apply`

OIDC terraform fmt/validate/plan/apply for main-branch deploys.

## Call

`actionsforge/actions/.github/workflows/terraform-apply.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/terraform-apply.yml@main
    with:
      working-directory: terraform
      commit-lock-file: true
    secrets:
      AWS_ACCOUNT_ID: ${{ secrets.AWS_ACCOUNT_ID }}
      # VERCEL_API_TOKEN: ${{ secrets.VERCEL_API_TOKEN }}  # optional TF_VAR
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `working-directory` | `string` | no | `.` | Path to the Terraform configuration directory |
| `aws-region` | `string` | no | `(empty)` | AWS region for OIDC (defaults to vars.AWS_REGION) |
| `terraform-version` | `string` | no | `(empty)` | Terraform version (defaults to vars.TERRAFORM_VERSION) |
| `init-upgrade` | `boolean` | no | `false` | Run terraform init -upgrade |
| `commit-lock-file` | `boolean` | no | `true` | Commit `.terraform.lock.hcl` changes after apply |

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

## Notes

- Pass secrets **explicitly** (do not use `secrets: inherit` across orgs).
- Only `AWS_ACCOUNT_ID` is required; other secrets are optional `TF_VAR_*` pass-through.
- `terraform fmt -check` is **strict** (job fails on format drift).
- Lock-file commit stages **only** `${working-directory}/.terraform.lock.hcl` — never `git add .` or `--force`.
- Apply uses `continue-on-error` so the lock-file step can still run; the job fails afterward if apply failed.
- Put `concurrency` on the **caller** so plan and apply can share one group.
- Caller needs `contents: write` when `commit-lock-file` is true.
- Caller variables: `OIDC_ROLE_NAME`, `AWS_REGION`, `TERRAFORM_VERSION`.

## Expected caller variables

| Variable | Purpose |
| --- | --- |
| `OIDC_ROLE_NAME` | IAM role name used in the OIDC assume-role ARN |
| `AWS_REGION` | Used when `aws-region` input is empty |
| `TERRAFORM_VERSION` | Used when `terraform-version` input is empty |
