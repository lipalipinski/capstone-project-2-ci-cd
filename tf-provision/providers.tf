terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket            = "tf-backend-jlipinski-1"
    key               = "tf/petclinic-app"
    region            = "eu-central-1"
    dynamodb_endpoint = "dynamodb.eu-central-1.amazonaws.com"
    dynamodb_table    = "tf-lock-jlipinski-1"
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region

  default_tags {
    tags = {
      Name    = "jlipinski-petclinic"
      Owner   = "jlipinski"
      Project = "2023_internship_waw"
    }
  }
}
