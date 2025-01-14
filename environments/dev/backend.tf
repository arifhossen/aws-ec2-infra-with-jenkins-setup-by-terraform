terraform {
  backend "s3" {
    bucket         = "devops-automation-infra"
    key            = "automation_pipeline_jenkins/dev/terraform.tfstate"
    region         = "us-east-1" # Region for poc,dev,pod,staging
    dynamodb_table = "devops-terraform-locks"
    encrypt        = true
    profile        = "ariftech"
  }
}
