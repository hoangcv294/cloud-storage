terraform {
  required_version = ">= 0.15.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8.0"
    }
  }
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "chevanhoang"
}