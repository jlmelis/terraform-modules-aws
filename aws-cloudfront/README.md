# AWS Cloudfront

A cloudfront distribution exists as the public entry point to the `web_resources` bucket.

## Inputs

| Input | Description |
| --- | --- |
| region | AWS Region to create resources in |
| logs_bucket_domain_name | The s3 bucket to store cloudfront access logs
| web_resources_bucket_id | The s3 bucket to allow cloudfront readonly access to |
| web_resources_bucket_regional_domain_name | The s3 bucket domain to associate with the cloudfront origin |
| web_resources_bucket_arn | The s3 bucket to allow cloudfront readonly access to |
| route53_domain_names | The route 53 domain names to use as an alias for the cloudfront distribution |
| route53_zone_id | The route 53 zone id to associate a route 53 A record with |
| acm_certificate_arn | The acm viewer certificate arn to use in the cloudfront distribution |

## Outputs

| Output | Description |
| --- | --- |
| domain_name | The domain name of the cloudfront distribution |

## Cache Behaviors

Caching for `index.html` in the `web_resources` bucket has been disabled. All other resources have a TTL of 3600 seconds

## Logging

Access / Network Logs are captured and stored in the `logs` bucket with a prefix of `log/cloudfront`

## Error Handling

403 and 404 errors are handled via an index.html page in the `web_resources` bucket.

## Security Headers

Cloudfront has been configured to include some common security headers. https://securityheaders.com/

- Content Type: nosniff
- Frame Options: DENY
- Referrer Policy: same-origin
- XSS Protection: 1; mode=block
- Strict Transport Security: max-age=63072000; includeSubDomains; preload
- Content Security Policy