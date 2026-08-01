# `notify-slack`

Post a Slack message via webhook (GitHub secret or Bitwarden).

## Call

`actionsforge/actions/.github/workflows/notify-slack.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/notify-slack.yml@main
    with:
      title: <value>
      text: <value>
      webhook-source: github
      include-run-link: true
      fail-on-error: false
    secrets:
      SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
      BW_ACCESS_TOKEN: ${{ secrets.BW_ACCESS_TOKEN }}
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `title` | `string` | yes | — | Slack message header |
| `text` | `string` | yes | — | Primary message body (mrkdwn-friendly plain text) |
| `webhook-source` | `string` | no | `github` | Where to load the webhook URL from (github or bitwarden) |
| `include-run-link` | `boolean` | no | `true` | Include a button linking to the triggering workflow run |
| `fail-on-error` | `boolean` | no | `false` | Fail the job if Slack delivery fails |
| `bitwarden-base-url` | `string` | no | `https://vault.bitwarden.com` | Bitwarden Secrets Manager API base URL |

## Secrets

| Name | Required | Description |
| --- | --- | --- |
| `SLACK_WEBHOOK_URL` | no | Incoming webhook URL (webhook-source=github) |
| `BW_ACCESS_TOKEN` | no | Bitwarden SM access token (webhook-source=bitwarden) |
| `BW_SLACK_WEBHOOK_SECRET_ID` | no | Bitwarden secret id for the Slack webhook URL |

Pass secrets **explicitly** when the caller and this repo are in different orgs (`secrets: inherit` does not cross organizations).

## Notes

- Prefer passing the webhook as an explicit secret when calling from another org.

