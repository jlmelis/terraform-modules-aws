output "repositories" {
  value = tomap({
    for k, repository in aws_ecr_repository.repository : k => repository.repository_url
  })
}