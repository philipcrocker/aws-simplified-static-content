terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.50.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile = "cdk-sandbox"
}

# provider "aws" {
#   region     = var.aws_region
#   access_key = var.aws_access_key
#   secret_key = var.aws_secret_access_key
# }
