# AWS ECS Cluster

Manages an ECS Cluster with container insights enabled. The cluster leverages the FARGATE capacity provider strategy. Network ingress is allowed on the `cluster_port`.

## Inputs

| Input                   | Description                                                                             | Default | Required |
| ----------------------- | --------------------------------------------------------------------------------------- | ------- | -------- |
| region                  | AWS Region to create resources in                                                       | N/A     | Yes      |
| tags                    | A set of key/value label pairs to assign to this to the resources                       | `{}`    | No       |
| role_arn                | The AWS assume role                                                                     | `""`    | No       |
| name                    | The name prefix to use for the ecs cluster, security group, IAM roles, and IAM policies | `""`    | No       |
| vpc_id                  | The VPC to associate the ecs cluster security groups with                               | `""`    | Yes      |
| cluster_security_groups | The ingress security groups for the cluster                                             | `[]`    | No       |
| cluster_port            | The ecs cluster ingress port                                                            | `5000`  | No       |

## Outputs

| Output                  | Description                                                |
| ----------------------- | ---------------------------------------------------------- |
| cluster_id              | The ARN that identifies the cluster.                       |
| cluster_name            | The name of the cluster                                    |
| security_groups         | ID of the security group associated with the load balancer |
| task_execution_role_arn | The ARN specifying the task execution role.                |
| task_role_arn           | The ARN specifying the task role.                          |
