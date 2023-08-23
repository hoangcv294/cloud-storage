# #######################-Get Data R53-#######################
data "aws_route53_zone" "hoangdevops" {
  name = var.domain_name # Replace with your domain name
}

#######################-Create Record Alias LoadBalancer-#######################
resource "aws_route53_record" "route53_record_alias" {
  zone_id = data.aws_route53_zone.hoangdevops.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_lb.cloud_storage_lb.dns_name
    zone_id                = aws_lb.cloud_storage_lb.zone_id
    evaluate_target_health = false
  }
}