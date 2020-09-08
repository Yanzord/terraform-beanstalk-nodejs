resource "aws_s3_bucket" "dist_bucket" {
  bucket = "${var.app_name}-${var.env}-dist-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id = "retention"
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name         = "${var.app_name}-${var.env}-dist-bucket"
    environment  = var.env
    project      = var.project
    team         = var.team
  }
}