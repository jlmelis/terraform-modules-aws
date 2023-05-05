# AWS ACM

Manaages an SSL certificate using DNS validation. Certificates can contain a `dns_name` and subject alternatives in up to two Route53 zones.

## Inputs

| Input                            | Description                                                                                                                                                                                             | Default | Required |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | -------- |
| region                           | AWS Region to create resources in                                                                                                                                                                       | N/A     | Yes      |
| tags                             | A set of key/value label pairs to assign to this to the resources                                                                                                                                       | `{}`    | No       |
| role_arn                         | The AWS assume role                                                                                                                                                                                     | `""`    | No       |
| dns_name                         | The domain name for which the certificate should be issued. A certificate and a Route53 DNS validation record will be created in the aws account granted by `role_arn`                                  | N/A     | Yes      |
| subject_alternative_names        | Set of domains that should be SANs in the issued certificate. A Route53 DNS validation record will be created for each subject_alternative_names in the aws account granted by `role_arn`               | `[]`    | No       |
| dns_zone_id                      | The ID of the Route53 hosted zone to contain the Certificate validation record for the `dns_name` and `subject_alternative_names`. The Route53 hosted zone must be accessible via the `role_arn`        | `""`    | Yes      |
| dns_ttl                          | The TTL to use for SSL certificates, and Route 53 records                                                                                                                                               | `60`    | No       |
| parent_subject_alternative_names | Set of domains that should be SANs in the issued certificate. A Route53 DNS validation record will be created for each parent_subject_alternative_names in the aws account granted by `parent_role_arn` | `[]`    | No       |
| parent_dns_zone_id               | The ID of the Route53 hosted zone to contain the Certificate validation record for the `parent_subject_alternative_names`. The Route53 hosted zone must be accessible via the `parent_role_arn`         | `""`    | Yes      |
| parent_role_arn                  | The AWS assume role                                                                                                                                                                                     | `""`    | No       |
| sns_alarm_topic_arn              | The SNS Topic ARN to use for Cloudwatch Alarms                                                                                                                                                          | `""`    | No       |
| alarm_expiration_threshold       | Number of days before certificate expiration to trigger an alarm                                                                                                                                        | `14`    | No       |

## Outputs

| Output          | Description                |
| --------------- | -------------------------- |
| certificate_arn | The ARN of the certificate |
