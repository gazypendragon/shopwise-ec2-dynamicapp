# environment variables
region       = "us-east-1"
project_name = "shopwise"
environment  = "prod"

# vpc variables
vpc_cidr                     = "10.0.0.0/16"
public_subnet_az1_cidr       = "10.0.0.0/24"
public_subnet_az2_cidr       = "10.0.1.0/24"
private_app_subnet_az1_cidr  = "10.0.2.0/24"
private_app_subnet_az2_cidr  = "10.0.3.0/24"
private_data_subnet_az1_cidr = "10.0.4.0/24"
private_data_subnet_az2_cidr = "10.0.5.0/24"

# # rds variables
db_engine              = "mysql"
db_engine_version      = "8.0.36"
db_multi_az_deployment = "false"
db_instance_identifier = "shopwise-db-instance"
db_username            = "cocoyo"
db_password            = "master1234"
db_name                = "shopwise1db"
db_instance_class      = "db.t3.micro"
availability_zone_2    = "us-east-1b"
publicly_accessible    = "false"

# acm variables
domain_name       = "ndefrusonsllc.com"
alternative_names = "*.ndefrusonsllc.com"

# route 53 variables
record_name = "www"

# sns variables
operator_email = "ndefrutitus22@gmail.com"

#Auto scaling group variables

launch_template_name = "shopwise-prod-lt"
ami_id               = "ami-06b21ccaeff8cd686"
ec2_instance_type    = "t2.micro"
ec2_key_pair_name    = "ec2key"
desired_capacity     = "2"
max_size             = "4"
min_size             = "1"