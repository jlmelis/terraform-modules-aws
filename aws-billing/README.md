# AWS Billing

## Inputs

| Input                     | Description                                                                             | Default | Required |
| ------------------------- | --------------------------------------------------------------------------------------- | ------- | -------- |
| region                    | AWS Region to create resources in                                                       | N/A     | Yes      |
| tags                      | A set of key/value label pairs to assign to this to the resources                       | `{}`    | No       |
| role_arn                  | The AWS assume role                                                                     | `""`    | No       |
| sns_alarm_topic_arn       | The SNS Topic ARN to use for Cloudwatch Alarms                                          | `""`    | No       |
| alarm_unheathly_threshold | Spend in USD that should cause an alarm if the estimated spend is greater than or equal | `300`   | No       |

## Outputs

| Output | Description |
| ------ | ----------- |
