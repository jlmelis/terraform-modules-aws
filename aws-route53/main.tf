resource "aws_route53_zone" "zone" {
  name = var.dns_name
}

resource "aws_route53_record" "ns_record_environment" {
  count    = var.parent_dns_zone_id != "" ? 1 : 0
  provider = aws.parent_dns_zone_account
  type     = "NS"
  zone_id  = var.parent_dns_zone_id
  name     = var.dns_name
  ttl      = var.dns_ttl
  records  = aws_route53_zone.zone.name_servers
}
