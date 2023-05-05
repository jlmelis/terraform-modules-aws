output "org" {
  value = aws_organizations_organization.org
}

output "non_master_accounts" {
  value = aws_organizations_organization.org.non_master_accounts
}

output "non_master_accounts_ids" {
  value = flatten([
    for non_master_account in aws_organizations_organization.org.non_master_accounts : non_master_account.id
  ])
}

output "aws_accounts_id" {
  value = { for account in aws_organizations_organization.org.accounts : account.name => account.id }
}

output "assumed_role_arns" {
  value = merge(flatten([
    for environment in keys(var.member_accounts) : [
      { for non_master_account in aws_organizations_organization.org.non_master_accounts : environment => "arn:aws:iam::${non_master_account.id}:role/${var.member_accounts[environment].role}" if non_master_account.name == var.member_accounts[environment].name }
    ]
  ])...)
}