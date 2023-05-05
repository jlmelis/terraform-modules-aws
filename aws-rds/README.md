# AWS RDS

Manages an autoscaling RDS Aurora Cluster running postgres sql with encrypted storage and backups.

## Inputs

| Input                    | Description                                                                                                            | Default        | Required |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------- | -------------- | -------- |
| region                   | AWS Region to create resources in                                                                                      | N/A            | Yes      |
| tags                     | A set of key/value label pairs to assign to this to the resources                                                      | `{}`           | No       |
| role_arn                 | The AWS assume role                                                                                                    | `""`           | No       |
| name                     | The name prefix for the database                                                                                       | `""`           | Yes      |
| instance_class           | Instance type to use at master instance. This will be the same instance class used on instances created by autoscaling | `db.t3.medium` | No       |
| engine_version           | The version of Aurora PostgreSQL. Updating this argument results in an outage                                          | `14.3`         | No       |
| autoscaling_min_capacity | The minimum number of read replicas permitted when autoscaling is enabled                                              | `1`            | No       |
| autoscaling_max_capacity | The maximum number of read replicas permitted when autoscaling is enabled                                              | `2`            | No       |
| backup_retention_days    | Number of days to retain backups                                                                                       | `7`            | No       |
| vpc_id                   | ID of the VPC where to create database cluster and security groups                                                     | `""`           | Yes      |
| cidr_block               | The CIDR block allowed to access the database                                                                          | `""`           | Yes      |
| subnet_ids               | List of subnet IDs used by database                                                                                    | `[]`           | Yes      |
| sns_alarm_topic_arn      | The SNS Topic ARN to use for Cloudwatch Alarms                                                                         | `""`           | No       |
| alarm_cpu_threshold      | CPU Percentage that should cause an alarm if the actual cpu average is greater than or equal for 300 seconds           | `90`           | No       |

## Outputs

| Output                  | Description                                                                       |
| ----------------------- | --------------------------------------------------------------------------------- |
| cluster_writer_endpoint | Writer endpoint for the cluster                                                   |
| cluster_reader_endpoint | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| cluster_port            | The database port                                                                 |
| cluster_master_username | The database master username                                                      |
| cluster_master_password | The database master password                                                      |
| cluster_database_name   | Name for database                                                                 |
