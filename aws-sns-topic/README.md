# AWS SNS Topic

## Inputs

| Input    | Description                                                       | Default | Required |
| -------- | ----------------------------------------------------------------- | ------- | -------- |
| region   | AWS Region to create resources in                                 | N/A     | Yes      |
| tags     | A set of key/value label pairs to assign to this to the resources | `{}`    | No       |
| role_arn | The AWS assume role                                               | `""`    | No       |
| name     | The name of the sns topic                                         | `""`    | Yes      |

## Outputs

| Output        | Description              |
| ------------- | ------------------------ |
| sns_topic_arn | The ARN of the SNS topic |
