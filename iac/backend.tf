# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "shopwise-ec2-terraform-remote-state"
    key            = "shopewise-ec2/terraform.tfstate"
    region         = "us-east-1"
    profile        = "Code-build-user"
    dynamodb_table = "terraform-state-lock"
  }
}