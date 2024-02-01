provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::734522607489:role/github-action"
  }
  region = "ap-south-1"
}