resource "aws_elastic_beanstalk_environment" "eb_env" {
  name = "${var.app_name}-${var.env}"
  application = aws_elastic_beanstalk_application.template-api-nodejs.name
  solution_stack_name = var.eb_solution_stack_name

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = element(tolist(data.aws_vpcs.main_vpc.ids), 0)
    resource  = ""
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${data.aws_subnet.private_subnet_a_cidr_block.id},${data.aws_subnet.private_subnet_b_cidr_block.id},${data.aws_subnet.private_subnet_c_cidr_block.id}"
    resource  = ""
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${data.aws_subnet.public_subnet_a_cidr_block.id},${data.aws_subnet.public_subnet_b_cidr_block.id},${data.aws_subnet.public_subnet_c_cidr_block.id}"
    resource  = ""
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.sg-ec2-template_api_nodejs.id
    resource  = ""
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.sg-lb-loadbalancer.id
    resource  = ""
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "ManagedSecurityGroup"
    value     = aws_security_group.sg-lb-loadbalancer.id
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
    resource  = ""
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_ec2.name
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.min_size
    resource  = ""
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max_size
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_role.beanstalk_service.name
    resource  = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
    resource  = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = var.environment_type
    resource  = ""
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "Protocol"
    value     = "HTTPS"
    resource  = ""
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLCertificateArns"
    value     = data.aws_acm_certificate.crt_template.arn
    resource  = ""
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLPolicy"
    value     = "ELBSecurityPolicy-2016-08"
    resource  = ""
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "ListenerEnabled"
    value     = "true"
    resource  = ""
  }
  setting {
    namespace = "aws:elbv2:listener:80"
    name      = "ListenerEnabled"
    value     = "false"
    resource  = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = var.healthcheck_url
    resource  = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
    resource  = ""
  }

  lifecycle {
    ignore_changes = [tags]
  }

  tags = {
    Name         = var.app_name
    environment  = var.env
    project      = var.project
    team         = var.team
  }
}