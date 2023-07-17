variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-0d13e3e640877b0b9"
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "bucket_prefix" {
  description = "Bucket Prefix"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Username of the database"
  type        = string
}

variable "db_password" {
  description = "Password of the database"
  type        = string
  sensitive   = true
}
