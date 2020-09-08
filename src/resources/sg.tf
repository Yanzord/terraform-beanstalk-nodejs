resource "aws_security_group" "sg-ec2-template_api_nodejs" {
    name = "sg_ec2-${var.app_name}"
    vpc_id = element(tolist(data.aws_vpcs.main_vpc.ids), 0) 

    ingress {
        description = "Internal access to API"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "sg_ec2-${var.app_name}"
        env = var.env
        project = var.project
        team = var.team
    }
}

resource "aws_security_group" "sg-lb-loadbalancer" {
    name = "sg_lb-${var.app_name}"
    vpc_id = element(tolist(data.aws_vpcs.main_vpc.ids), 0) 

    ingress {
        description = "HTTP Access to external IPs"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = var.allowed_cidrs
    }

    ingress {
        description = "HTTPS Access to external IPs"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = var.allowed_cidrs
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "sg_lb-${var.app_name}"
        env = var.env
        project = var.project
        team = var.team
    }
}