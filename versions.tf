terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.64"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 2.2"
    }
  }
}
