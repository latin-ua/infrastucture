terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }

    archive = {
      source = "hashicorp/archive"
      version = "2.4.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-991225504892"
    key    = "tf_state/terraform.tfstate"
    region = "eu-central-1"
  }
}

# Configure the AWS Provider
provider "aws" {
}

provider "archive" {
}