terraform {
  # Assumes s3 bucket and dynamo DB table already set up

  backend "s3" {
    bucket         = "himan-tf-state"
    key            = "03-basics/web-app/terraform.tfstate"
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

variable "db_pass_1" {
  description = "password for database #1"
  type        = string
  sensitive   = true
}

variable "db_pass_2" {
  description = "password for database #2"
  type        = string
  sensitive   = true
}

module "web_app_1" {
  source = "../web-app-module"

  # Input Variables
  bucket_prefix    = "web-app-1-data"
  app_name         = "web-app-1"
  environment_name = "production"
  instance_type    = "t2.micro"
  db_name          = "webapp1db"
  db_user          = "foo1"
  db_pass          = var.db_pass_1
}

module "web_app_1" {
  source = "../web-app-module"

  # Input Variables
  bucket_prefix    = "web-app-2-data"
  app_name         = "web-app-2"
  environment_name = "production"
  instance_type    = "t2.micro"
  db_name          = "webapp2db"
  db_user          = "foo2"
  db_pass          = var.db_pass_2
}
