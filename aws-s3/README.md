# S3 Web Resources

Storage location for static files. Public access to these files is disabled as it is assumed access will be managed through other AWS resources such as Cloudfront or properly users.

## Inputs

| Input          | Description |
|----------------| --- |
| region         | AWS Region to create resources in |
| environment    | Environment name (e.g "staging") the resource is created for.  Since S3 buckets are globally unique the environment name will be included in the bucket name |

## Outputs

| Output | Description |
| --- | --- |
| bucket_id | The ID of the bucket can be used to by other modules when defining bucket policies |
| bucket_regional_domain_name | The bucket regional domain name is exposed primarily for association with Cloudfront origins |
| bucket_arn | The bucket arn can be used by other modules when defining IAM policies that grant access to this bucket |

## Versioning

S3 Versioning is disabled for this bucket as the contents of the bucket represent a release that is controlled by a CI/CD system.  The CI/CD system will be treated as the system of record for version root.