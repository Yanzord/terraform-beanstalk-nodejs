data "aws_elastic_beanstalk_hosted_zone" "current" {}

data "aws_route53_zone" "devops-zone" {
  name         = "${var.record}."
  private_zone = false
}

resource "aws_route53_record" "devops" {
  zone_id = data.aws_route53_zone.devops-zone.zone_id
  name    = "template-api-nodejs.${data.aws_route53_zone.devops-zone.name}"
  type    = "A"

  alias {
    name                   = aws_elastic_beanstalk_environment.eb_env.cname
    zone_id                = data.aws_elastic_beanstalk_hosted_zone.current.id
    evaluate_target_health = true
  }
}