terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "my-fancy-job-terraform-45678"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}



# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"


data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  role_arn = join(":", ["arn", "aws", "iam", "", local.account_id, "role/LabRole"])
}

}
