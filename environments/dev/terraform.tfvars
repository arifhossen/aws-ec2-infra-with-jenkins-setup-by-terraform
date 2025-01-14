region       = "us-east-1"
stage        = "dev"
aws_profile  = "ariftech"
project_name = "jenkins-server"

#EC2 Machine Information
ami_id        = "ami-0e2c8caa4b6378d8c" //Ubuntu Server 24.04 LTS (HVM),EBS General Purpose (SSD) Volume Type. Support available from Canonical (http://www.ubuntu.com/cloud/services).
instance_type = "t2.small"
ec2_user_data = "userdata.sh"
cidr_block    = "10.0.0.0/16"

#Public Subnet CIDR Information
public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.2.0/24"

#Private Subnet CIDR Information
private_subnet_1_cidr = "10.0.3.0/24"
private_subnet_2_cidr = "10.0.4.0/24"

#Route Table CIDR Information
public_route_tbl_cidr_block = "0.0.0.0/0"

#Availability Zone Information
availability_zone_1 = "us-east-1a"
availability_zone_2 = "us-east-1b"

