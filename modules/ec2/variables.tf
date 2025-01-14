
variable "stage" {
  description = "Staging name"
  type        = string
}
variable "project_name" {
  description = "Project name"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = list(string)
}
variable "security_group_id" {
  description = "Security Group id"
  type        = string
}

variable "security_group_name" {
  description = "Security Group Name"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instances"
  type        = string
}

