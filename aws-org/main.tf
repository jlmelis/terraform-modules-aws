resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "access-analyzer.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com"
  ]

  enabled_policy_types = []

  feature_set = "ALL"
}

resource "aws_organizations_account" "account" {
  for_each = var.member_accounts

  name      = each.value.name
  email     = each.value.email
  role_name = each.value.role

  # There is no AWS Organizations API for reading role_name
  lifecycle {
    ignore_changes = [role_name]
  }

  depends_on = [aws_organizations_organization.org]
}
