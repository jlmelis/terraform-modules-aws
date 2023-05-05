# S3 Web Resources

Storage location for access logs. Logs written to this bucket are encrypted with server side encryption AES256 and are retained for 7 days by default. Public access to the log files is disabled by default.

## Inputs

| Input | Description |
| --- | --- |
| region | AWS Region to create resources in |
| environmemt | Environment name (e.g "staging") the resource is created for.  Since S3 buckets are globally unique the environment name will be included in the bucket name |
| log_retention_days | The number of days to retain log files.  Default is 7 days

## Outputs

| Output | Description |
| --- | --- |
| bucket_id | The ID of the bucket can be used to by other modules when defining bucket policies |
| bucket_domain_name | The bucket domain name is exposed primarily for cloudfront logging purposes |

## Versioning

S3 Versioning is disabled for this bucket as the contents of the bucket represent time based logs that will never have more than one version.