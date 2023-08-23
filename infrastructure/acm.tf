#######################-Get Data ACM-#######################
data "aws_acm_certificate" "cloud_storage_cert" {
  # provider = "ap-southeast-1"
  domain   = var.domain_name
  statuses = ["ISSUED"]
}

