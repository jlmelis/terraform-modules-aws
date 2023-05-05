# AWS IAM ROLE

This module creates an AWS IAM Role and sets up a trust relationship

## Inputs

| Input               | Description                                                     | Default                                     | Required |
| ------------------- | --------------------------------------------------------------- | ------------------------------------------- | -------- |
| name                | The name of the role to allow for a trust relationship          | developertown-admins                        | Yes      |
| account             | The account number to allow for a trust relationship            | 216430079837                                | Yes      |
| principal_tag_key   | The key of the tag to use to check for access permissions       |                                             | Yes      |
| principal_tag_value | The value of the tag to use to check for access permissions     |                                             | Yes      |
| policy_arn          | The ARN of the AWS managed policy to attach to the created role | arn:aws:iam::aws:policy/AdministratorAccess | Yes      |
| role_arn            | The AWS assume role                                             |                                             | Yes      |

## Outputs

| Output       | Description         |
| ------------ | ------------------- |
| iam_role_arn | The ARN of IAM role |
