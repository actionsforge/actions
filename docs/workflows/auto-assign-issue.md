# `auto-assign-issue`

Auto-assign new issues.

## Call

`actionsforge/actions/.github/workflows/auto-assign-issue.yml@main`

## Example

```yaml
jobs:
  call:
    uses: actionsforge/actions/.github/workflows/auto-assign-issue.yml@main
    with:
      assignees: jajera
      numOfAssignee: 5
      abortIfPreviousAssignees: false
      removePreviousAssignees: false
```

## Inputs

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `assignees` | `string` | no | `jajera` | Comma separated list of user names. Issue will be assigned to those users. |
| `numOfAssignee` | `number` | no | `5` | Number of assignees that will be randomly picked from the teams or assignees. |
| `abortIfPreviousAssignees` | `boolean` | no | `false` | Flag that aborts the action if there were assignees previously. |
| `removePreviousAssignees` | `boolean` | no | `false` | Flag that removes assignees before assigning them (useful the issue is reasigned). |
| `allowNoAssignees` | `boolean` | no | `false` | Flag that prevents the action from failing when there are no assignees. |
| `allowSelfAssign` | `boolean` | no | `true` | Flag that allows self-assignment to the issue author. |

