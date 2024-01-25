provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::734522607489:role/terraform-infra-create-role"
  }
  region = "ap-south-1"
}