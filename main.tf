terraform {
  backend "remote" {
    organization = "Gravityloop"
    workspaces {
      name = "infraAsCode"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

module "app_server" {
  source        = format("%s/app_server", var.custom_module_base_url)
  instance_name = "testInstance"
  ami_id        = "ami-0742b4e673072066f"
}