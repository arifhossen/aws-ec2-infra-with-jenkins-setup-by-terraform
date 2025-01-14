variable "region" {
  description = "AWS region for deployment"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
}

variable "stage" {
  description = "Stage dev,staging,prod"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}
variable "ami_id" {
  description = "AWS Machine ami id"
  type        = string
}

variable "instance_type" {
  description = "AWS Machine Instance Type"
  type        = string
}

variable "cidr_block" {
  description = "VPC CIDR Block"
  type        = string
}


variable "public_subnet_1_cidr" {
  description = "Public subnet 1 CIDR Block"
  type        = string
}


variable "public_subnet_2_cidr" {
  description = "Public subnet 2 CIDR Block"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "Private subnet 1 CIDR Block"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "Private subnet 2 CIDR Block"
  type        = string
}

variable "public_route_tbl_cidr_block" {
  description = "Public Route table CIDR Block"
  type        = string
}

variable "availability_zone_1" {
  description = "Availability Zone 1"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability Zone 2"
  type        = string
}

