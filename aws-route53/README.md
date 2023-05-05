# AWS Route 53

Manages a Route53 zone and optionally name servers for the zone in a parent or apex zone.

## Inputs

| Input              | Description                                                       | Default | Required |
| ------------------ | ----------------------------------------------------------------- | ------- | -------- |
| region             | AWS Region to create resources in                                 | N/A     | Yes      |
| tags               | A set of key/value label pairs to assign to this to the resources | `{}`    | No       |
| role_arn           | The AWS assume role                                               | `""`    | No       |
| dns_name           | The DNS zone to create                                            | N/A     | Yes      |
| dns_ttl            | The TTL for Route53 NS Records                                    | `60`    | No       |
| parent_dns_zone_id | The Route53 Zone to create an NS Record                           | `""`    | No       |
| parent_role_arn    | The AWS assume role                                               | `""`    | No       |

## Outputs

| Output       | Description                             |
| ------------ | --------------------------------------- |
| domain_name  | The domain name created in the dns zone |
| name_servers | The name servers for the dns zone       |
| zone_id      | The Route53 Zone ID                     |
