# AWS ECS Service

Manages an autoscaling ECS Service and Task.

## Inputs

| Input                           | Description                                                                                                                | Default | Required |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------- | ------- | -------- |
| region                          | AWS Region to create resources in                                                                                          | N/A     | Yes      |
| tags                            | A set of key/value label pairs to assign to this to the resources                                                          | `{}`    | No       |
| role_arn                        | The AWS assume role                                                                                                        | `""`    | No       |
| name                            | The name prefix to use for the ecs task definition, service, autoscaling policies, and cloudwatch log group                | `""`    | Yes      |
| subnet_ids                      | The subnets to associate with the ecs service                                                                              | `[]`    | Yes      |
| cluster_security_groups         | The security groups to associate with the ecs service                                                                      | `[]`    | Yes      |
| cluster_id                      | The ARN of an ECS cluster                                                                                                  | `""`    | Yes      |
| cluster_name                    | The name of the ECS cluster, used to identify the autoscaling resource target                                              | `""`    | Yes      |
| cluster_port                    | The ECS Cluster / ECS Task Port Mapping                                                                                    | `5000`  | No       |
| cluster_task_execution_role_arn | The cluster task execution role arn                                                                                        | `""`    | Yes      |
| cluster_task_role_arn           | The cluster task role arn                                                                                                  | `""`    | Yes      |
| load_balancer_target_group_arn  | ARN of the Load Balancer target group to associate with the service                                                        | `""`    | Yes      |
| cpu                             | Number of cpu units used by the ecs service                                                                                | `256`   | No       |
| memory                          | Amount (in MiB) of memory used by the ecs service                                                                          | `512`   | No       |
| desired_count                   | Number of instances of the task definition to place and keep running                                                       | `2`     | No       |
| min_count                       | Minimum number of instances of the task definition to place and keep running                                               | `1`     | No       |
| max_count                       | Maxiumum number of instances of the task definition to place and keep running                                              | `4`     | No       |
| image_repository                | The name of the ECR image repository                                                                                       | `""`    | Yes      |
| image_name                      | The name of the image to pull from Amazon ECR                                                                              | `""`    | Yes      |
| image_tag                       | The tag of the image to pull from Amazon ECR                                                                               | `""`    | Yes      |
| secrets                         | A set of key/value secret pairs to read from secrets manager and provide as environment variables to the ecs task          | `{}`    | No       |
| environment                     | A set of key/value to provide as environment variables to the ecs task                                                     | `{}`    | No       |
| init_image_repository           | The name of the init container ECR image repository                                                                        | `""`    | No       |
| init_image_name                 | The name of the init container image to pull from Amazon ECR                                                               | `""`    | No       |
| init_image_tag                  | The tag of the init container image to pull from Amazon ECR                                                                | `""`    | No       |
| log_retention_days              | Number of days to retain logs                                                                                              | `7`     | No       |
| sns_alarm_topic_arn             | The SNS Topic ARN to use for Cloudwatch Alarms                                                                             | `""`    | No       |
| alarm_cpu_threshold             | CPU Percentage that should cause an alarm if the actual cpu average is greater than or equal for 300 seconds               | `90`    | No       |
| alarm_memory_threshold          | Memory Percentage that should cause an alarm if the actual memory average is greater than or equal for 300 seconds seconds | `90`    | No       |
| alarm_error_threshold           | Number of error logs that should cause an alarm when the average is greater than or equal for 300 seconds                  | `100`   | No       |

## Outputs

| Output | Description |
| ------ | ----------- |
