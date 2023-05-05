# AWS LB

Manages an classic load balancer alias that allows ingress from the public internet. 

## Inputs

| Input                     | Description                                                                                                                       | Default                 | Required |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------- | -------- |
| region                    | AWS Region to create resources in                                                                                                 | N/A                     | Yes      |
| tags                      | A set of key/value label pairs to assign to this to the resources                                                                 | `{}`                    | No       |
| role_arn                  | The AWS assume role                                                                                                               | `""`                    | No       |
| name                      | The name prefix to use for the load balancer, security groups, and target group.                                                  | `""`                    | Yes      |
| vpc_id                    | The VPC to associate the load balancer security groups, and target group with.                                                    | `""`                    | Yes      |
| subnet_ids                | A list of subnet IDs to attach to the load balancer.                                                                              | `[]`                    | Yes      |

## Outputs

| Output           | Description                                                   |
| ---------------- | ------------------------------------------------------------- |
| security_groups  | ID of the security group associated with the load balancer    |
| target_group_arn | The ARN of the Target Group associated with the load balancer |
