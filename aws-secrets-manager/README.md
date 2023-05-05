# AWS Secrets Manager

Manages a secret manager secret containing jsonencoded values.

## Inputs

| Input    | Description                                                       | Default | Required |
| -------- | ----------------------------------------------------------------- | ------- | -------- |
| region   | AWS Region to create resources in                                 | N/A     | Yes      |
| tags     | A set of key/value label pairs to assign to this to the resources | `{}`    | No       |
| role_arn | The AWS assume role                                               | `""`    | No       |
| name     | The name prefix of the new secret                                 | `""`    | Yes      |
| secrets  | A set of key/value secret pairs to store in secrets manager       | `{}`    | No       |

## Outputs

| Output  | Description                                               |
| ------- | --------------------------------------------------------- |
| secrets | A mapping of secret key to the location in secret manager |
