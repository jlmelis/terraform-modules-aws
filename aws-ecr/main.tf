#tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "repository" {
  for_each             = toset(var.repositories)
  name                 = each.key
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "repository" {
  for_each   = toset(var.repositories)
  repository = aws_ecr_repository.repository[each.key].name
  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid    = "CrossAccountPermission",
        Effect = "Allow"
        Action = [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability"
        ]
        Principal = { "AWS" : flatten([
          for account_id in var.additional_aws_account_access : [
            "arn:aws:iam::${account_id}:root"
          ]
        ]) },
      },
    ]
  })
}

resource "aws_ecr_lifecycle_policy" "expireimages" {
  for_each   = toset(var.repositories)
  repository = aws_ecr_repository.repository[each.key].name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last ${var.image_retention_count} images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = var.image_retention_count
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_replication_configuration" "replication" {
  replication_configuration {
    rule {

      dynamic "destination" {
        for_each = var.additional_aws_account_access
        content {
          region      = var.region
          registry_id = destination.value
        }
      }
    }
  }
}