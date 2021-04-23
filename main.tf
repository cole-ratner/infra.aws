# -------------------------------------------------------------------------------------------
# Declaring the provider & a remote backend hosted by terraform cloud to manage state 
# and to perform the terraform operations remotely
# -------------------------------------------------------------------------------------------
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

locals {
  custom_module_base_url = "github.com/cole-ratner/terraform_modules"
}

# -------------------------------------------------------------------------------------------
# Defining infra resources to provision by the previously declared provider
# -------------------------------------------------------------------------------------------
module "app_server" {
  source        = "${local.custom_module_base_url}/app_server"
  instance_name = "testInstance"
  ami_id        = "ami-0742b4e673072066f"
}

