resource "aws_elastic_beanstalk_application" "template-api-nodejs" {
  name = var.app_name

  appversion_lifecycle {
    service_role          = aws_iam_role.beanstalk_service.arn
    max_count             = 128
    delete_source_from_s3 = true
  }

  lifecycle {
    ignore_changes = [tags]
  }

  tags = {
    Name         = "${var.app_name}-${var.env}"
    environment  = var.env
    project      = var.project
    team         = var.team
  }
}