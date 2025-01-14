# AWS EC2 Infrastructure create and Jenkins Setup using Terraform

This project provides a Terraform-based solution for creating and managing AWS Keypairs, Security Groups, Virtual Private Clouds (VPC), and EC2 instances as reusable modules. The modules are designed to simplify the infrastructure deployment process and can be integrated into larger projects.

## Table of Contents
- [Modules Overview](#modules-overview)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
  - [1. Clone the Repository](#1-clone-the-repository)
  - [2. Configure Terraform Variables](#2-configure-terraform-variables)
  - [3. Initialize Terraform](#3-initialize-terraform)
  - [4. Apply the Terraform Configuration](#4-apply-the-terraform-configuration)
- [Modules Description](#modules-description)
- [Outputs](#outputs)
- [Clean Up](#clean-up)
- [Notes](#notes)

## Modules Overview
This project consists of the following Terraform modules:

1. **Keypair Module**: Creates an EC2 key pair for secure SSH access to instances.
2. **Security Group Module**: Defines security groups for managing inbound and outbound traffic.
3. **VPC Module**: Sets up a custom VPC with subnets and other network components.
4. **EC2 Module**: Provisions EC2 instances with the desired configurations.

## Prerequisites

- An AWS account with IAM permissions to create the specified resources.
- Terraform installed on your local machine ([Download Terraform](https://www.terraform.io/downloads.html)).
- AWS CLI configured with the necessary profile.

## Setup Instructions

### 1. Clone the Repository
Clone the repository to your local machine:
```bash
git clone https://github.com/your-repo/aws-modules-terraform.git
cd aws-modules-terraform
```

### 2. Project Structure Below
Here is the corrected tree structure reflecting that the `modules/` directory contains global configuration files (`main.tf`, `variables.tf`, `outputs.tf`), and each module folder (e.g., `keypair`, `security-group`, etc.) contains its own `main.tf`, `variables.tf`, and `outputs.tf` files:

```plaintext
project-root/
├── modules/
│   ├── main.tf
│   ├── variables.tf
│   ├── provider.tf
│   ├── keypair/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ec2/
│       ├── main.tf
│       ├── variables.tf
│       ├── userdata.sh
│       └── outputs.tf
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
```


This structure allows for clear separation of shared configurations, reusable modules, and environment-specific settings.

## Modules Description

### Keypair Module
- Creates an EC2 key pair.
- Stores the private key in the local directory.

### Security Group Module
- Defines ingress and egress rules.
- Allows SSH access (port 22) and other configurable ports.

### VPC Module
- Creates a VPC with the specified CIDR block.
- Includes public and private subnets.
- Sets up an Internet Gateway and Route Tables.

### EC2 Module
- Launches an EC2 instance in the specified subnet.
- Associates the instance with the created key pair and security group.
- Use userdata for install Jenkins,Docker,zip packages in ec2 instance



### 3. Configure Backend
---

To configure the Terraform backend, we use Amazon S3 for storing the state files and DynamoDB for state locking to ensure only one operation modifies the infrastructure at a time. Follow these steps to create the necessary resources:

1. **Create an S3 Bucket**:
   - The S3 bucket `devops-automation-infra` is used to store Terraform state files.
   - Ensure the bucket is in the correct AWS region (e.g., `us-east-1` for `dev`, `staging`, etc.).
   - Enable versioning for better management of Terraform state.

2. **Create a DynamoDB Table**:
   - The DynamoDB table `devops-terraform-locks` is used for state locking to prevent concurrent runs of Terraform.
   - Set the primary key as `LockID` (String type).
   - Enable the table with provisioned capacity or on-demand capacity, depending on the expected workload.

After creating these resources, update your Terraform configuration to point to the correct bucket and table for the backend.

```hcl
terraform {
  backend "s3" {
    bucket         = "devops-automation-infra"
    key            = "automation_pipeline_jenkins/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops-terraform-locks"
    encrypt        = true
    profile        = "ariftech"
  }
}
```

--- 

This description explains the setup of the S3 bucket and DynamoDB table for backend configuration in a clear and concise way for your README file.


### 3. Configure Terraform Variables
Location environments/dev/terraform.tfvars

Update the `terraform.tfvars` file with your configuration:
```hcl
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
```

### 4. Initialize Terraform
Run the following command to initialize the Terraform working directory:
```bash
cd environments/dev
terraform init
```

### 5. Apply the Terraform Configuration
Apply the configuration to create the AWS resources:
```bash
terraform apply
```
Type `yes` when prompted.

## Clean Up
To remove all resources created by this project, run:
```bash
terraform destroy
```
Type `yes` when prompted.

## Notes
- Ensure the EC2 key pair already exists in your AWS account, or let Terraform create it for you.
- Modify the Security Group rules to restrict access to specific IP addresses for production environments.
- Use the VPC ID and Subnet IDs from the outputs for integrating with other AWS services.


## Step 6: After Create ec2 instance infrastructure also install Jenkins
## 7. Unlock Jenkins  

After Jenkins is installed, you need to unlock it to complete the setup. The initial admin password is stored in a file on the server. Follow these steps to retrieve it:  

#### 7.1 Connect to the EC2 Instance  
Use SSH to connect to your EC2 instance:  
```bash
ssh -i jenkins-server-KeyPair-dev.pem ubuntu@<instance-public-ip>
```  

#### 7.2 Retrieve the Initial Admin Password  
The initial admin password is stored in the following file:  
```
/var/lib/jenkins/secrets/initialAdminPassword
```  

Run the following command to view the password:  
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```  

#### 7.3  Unlock Jenkins  
1. Copy the password displayed in the terminal.  
2. Open your web browser and navigate to:  
   ```
   http://<instance-public-ip>:8080
   ```  
3. Paste the password into the "Administrator password" field and click **Continue**.  

#### 7.4 Complete Jenkins Setup  
1. Install the recommended plugins or select specific ones based on your requirements.  
2. Create an admin user for Jenkins.  
3. Finalize the setup and start using Jenkins.  

**Note:**  
- Ensure port `8080` is open in your security group to allow web access to Jenkins.  
- Store the admin password securely if needed for future reference.  
```  

