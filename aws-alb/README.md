# AWS ALB

Manages an application load balancer with Route53 alias that allows ingress from the public internet from both SSL and non-SSL traffic. The load balancer will automatically redirect to SSL when traffic is non-SSL.

## Inputs

| Input                     | Description                                                                                                                       | Default                 | Required |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------- | -------- |
| region                    | AWS Region to create resources in                                                                                                 | N/A                     | Yes      |
| tags                      | A set of key/value label pairs to assign to this to the resources                                                                 | `{}`                    | No       |
| role_arn                  | The AWS assume role                                                                                                               | `""`                    | No       |
| name                      | The name prefix to use for the load balancer, security groups, and target group.                                                  | `""`                    | Yes      |
| vpc_id                    | The VPC to associate the load balancer security groups, and target group with.                                                    | `""`                    | Yes      |
| subnet_ids                | A list of subnet IDs to attach to the load balancer.                                                                              | `[]`                    | Yes      |
| certificate_arn           | The certificate to use with the SSL listener                                                                                      | `""`                    | Yes      |
| http_port                 | Port on which the load balancer is listening                                                                                      | `80`                    | No       |
| https_port                | SSL Port on which the load balancer is listening                                                                                  | `443`                   | No       |
| health_check_path         | Destination for the health check request.                                                                                         | `"/swagger/index.html"` | No       |
| dns_zone_id               | The ID of the Route53 hosted zone to create an alias record. The Route53 hosted zone must be accessible via the dns_zone_role_arn | `""`                    | No       |
| dns_record_name           | The DNS name to use to create an alias record. The Route53 hosted zone must be accessible via the dns_zone_role_arn               | `""`                    | No       |
| dns_zone_role_arn         | The AWS assume role                                                                                                               | `""`                    | No       |
| sns_alarm_topic_arn       | The SNS Topic ARN to use for Cloudwatch Alarms                                                                                    | `""`                    | No       |
| alarm_unheathly_threshold | Number of unheathy hosts that should cause an alarm if the actual is greater than or equal for 60 seconds                         | `1`                     | No       |

## Outputs

| Output           | Description                                                   |
| ---------------- | ------------------------------------------------------------- |
| security_groups  | ID of the security group associated with the load balancer    |
| target_group_arn | The ARN of the Target Group associated with the load balancer |
