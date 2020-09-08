provider "aws" {
  region = var.region
}

terraform {
    backend "s3" {
    }
}

variable "app_name" {
  default = "template-api-nodejs"
}

variable "env" {
  default = "dev"
}

variable "project" {
  default = "devops"
}

variable "team" {
  default = "arquitetura"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_name" {
  default = "vpc-dev"
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 1
}

variable "instance_type" {
  default = "t2.medium"
}

variable "eb_solution_stack_name" {
  default = "64bit Amazon Linux 2 v5.2.1 running Node.js 12"
}

variable "private_subnets" {
    type = map
    default = {
        "subnet1"    = "dev-vpc-private-a"
        "subnet2"    = "dev-vpc-private-b"
        "subnet3"    = "dev-vpc-private-c"
    }
}

variable "public_subnets" {
    type = map
    default = {
        "subnet1"    = "dev-vpc-public-a"
        "subnet2"    = "dev-vpc-public-b"
        "subnet3"    = "dev-vpc-public-c"
    }
}

variable "allowed_cidrs" {
  default = ["0.0.0.0/0"]
}

variable "environment_type" {
  default = "LoadBalanced"
}

variable "healthcheck_url" {
  default = "/"
}

variable "mount_target_ip_address" {
  type        = string
  default     = ""
}

variable "workspace" {
  description = "Project root folder."
  default     = ""
}

variable "domain" {
  default = ""
}

variable "record" {
  default = ""
}