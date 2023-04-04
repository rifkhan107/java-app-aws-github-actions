terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.15.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_ecr_repository" "this" {
  name = "my-spring-boot-app"
}

locals {
  cluster_name = "my-eks-cluster"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 17.0"

  cluster_name = local.cluster_name
  subnets      = module.vpc.public_subnets

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  vpc_id = module.vpc.vpc_id

  # To add more nodes to the cluster, update the desired capacity.
  node_groups = {
    default = {
      instance_type = "t2.small"
      additional_tags = {
        Terraform = "true"
        Environment = "dev"
      }
      desired_capacity = 2
    }
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.this.repository_url
}
