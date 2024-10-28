# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name "
  type        = string
}

variable "environment" {
  description = "name of enviroment"
  type        = string
}

#vpc variables
variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
}

variable "public_subnet_az1_cidr" {
  description = "public subnet az1 block"
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "public subnet az2 block"
  type        = string
}

variable "private_app_subnet_az1_cidr" {
  description = "private app subnet az1 block"
  type        = string
}

variable "private_app_subnet_az2_cidr" {
  description = "private app subnet az2 block"
  type        = string
}

variable "private_data_subnet_az1_cidr" {
  description = "private data subnet az1 block"
  type        = string
}

variable "private_data_subnet_az2_cidr" {
  description = "private data subnet az2 block"
  type        = string
}

# # rds variables
variable "db_engine" {
  description = "mysql database engine"
  type        = string
}

variable "db_engine_version" {
  description = " mysql database engine version"
  type        = string
}

variable "db_multi_az_deployment" {
  description = "create a standby db instance"
  type        = bool
}

variable "db_instance_identifier" {
  description = "database instance identifier"
  type        = string
}

variable "db_username" {
  description = "The username for the master user"
  type        = string
}

variable "db_password" {
  description = "The password for the master user"
  type        = string
}

variable "db_name" {
  description = " The name of the initial database to create"
  type        = string
}

variable "db_instance_class" {
  description = "create a standby db instance"
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance"
  type        = string
}

variable "availability_zone_2" {
  description = "The availability zone for the RDS instance"
  type        = string
}

variable "publicly_accessible" {
  description = "controls if instance is publicly accessible"
  type        = bool
}

variable "record_name" {
  description = "database snapshot name"
  type        = string
}

# acm variables 
variable "domain_name" {
  description = "datatbase instance identifier"
  type        = string
}

# sns variables
variable "alternative_names" {
  description = "sub domain name for an SSL certificate"
  type        = string
}

variable "operator_email" {
  description = "Email address of the operator for notifications"
  type        = string
}

variable "ec2_instance_type" {
  description = "The EC2 instance type."
  type        = string
}

variable "ec2_key_pair_name" {
  description = "EC2 instance key"
  type        = string
}

variable "max_size" {
  description = "Maximum size of the ASG"
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity of the ASG"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the ASG"
  type        = number
}

variable "launch_template_name" {
  description = "Name of the launch template used to provision ec2"
  type        = string
}