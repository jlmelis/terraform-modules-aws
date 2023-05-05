# AWS ECR

Manages immutable ECR repositories with AES256 encryption and secruity scanning. Image retention is limited to the `image_retention_count` and readonly / pull access can be granted to additional aws accounts via the `additional_aws_account_access`

## Inputs

| Input                         | Description                                                       | Default | Required |
| ----------------------------- | ----------------------------------------------------------------- | ------- | -------- |
| region                        | AWS Region to create resources in                                 | N/A     | Yes      |
| tags                          | A set of key/value label pairs to assign to this to the resources | `{}`    | No       |
| role_arn                      | The AWS assume role                                               | `""`    | No       |
| repositories                  | The ECR repositories to create                                    | `[]`    | No       |
| image_retention_count         | The number of tagged images to retain                             | `60`    | No       |
| additional_aws_account_access | Additional aws accounts with readonly access to the repositories  | `[]`    | No       |

## Outputs

| Output       | Description                                                                 |
| ------------ | --------------------------------------------------------------------------- |
| repositories | A mapping of the repositories that were created and there corresponding url |
