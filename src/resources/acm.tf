data "aws_acm_certificate" "crt_template" {
  domain   = var.domain
  statuses = ["ISSUED"]
}
