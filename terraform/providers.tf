terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0" # AWS provider >=4.x is compatible with Terraform 1.3
    }
  }
}

provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

