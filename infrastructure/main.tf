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
}