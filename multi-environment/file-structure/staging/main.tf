terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  backend "s3" {
    bucket         = "himan-tf-state"
    key            = "multi-environments/staging/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

variable "db_password" {
  description = "password for database"
  type        = string
  sensitive   = true
}

locals {
  environment_name = "staging"
}

module "web_app" {
  source = "../../../modules/web-app-module"

  # Input Variables
  bucket_prefix    = "web-app-data-${local.environment_name}"
  environment_name = local.environment_name
  instance_type    = "t2.micro"
  db_name          = "${local.environment_name}mydb"
  db_username      = "foo"
  db_password      = var.db_password
}
