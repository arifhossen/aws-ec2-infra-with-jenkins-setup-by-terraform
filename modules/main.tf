
#VPC Module
module "vpc" {
  source                      = "./vpc"
  stage                       = var.stage
  project_name                = var.project_name
  cidr_block                  = var.cidr_block
  public_subnet_1_cidr        = var.public_subnet_1_cidr
  public_subnet_2_cidr        = var.public_subnet_2_cidr
  private_subnet_1_cidr       = var.private_subnet_1_cidr
  private_subnet_2_cidr       = var.private_subnet_2_cidr
  public_route_tbl_cidr_block = var.public_route_tbl_cidr_block
  availability_zone_1         = var.availability_zone_1
  availability_zone_2         = var.availability_zone_2
}
# Security Group Module
module "security_group" {
  source       = "./security-group"
  vpc_id       = module.vpc.vpc_id
  stage        = var.stage
  project_name = var.project_name
}

# Key Pair for EC2
module "keypair" {
  source       = "./keypair"
  stage        = var.stage
  project_name = var.project_name
}

# EC2
module "ec2" {
  source              = "./ec2"
  stage               = var.stage
  project_name        = var.project_name
  ami_id              = var.ami_id
  key_name            = module.keypair.key_name
  vpc_id              = module.vpc.vpc_id
  instance_type       = var.instance_type
  subnet_ids          = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  security_group_id   = module.security_group.security_group_id
  security_group_name = module.security_group.security_group_name
}

