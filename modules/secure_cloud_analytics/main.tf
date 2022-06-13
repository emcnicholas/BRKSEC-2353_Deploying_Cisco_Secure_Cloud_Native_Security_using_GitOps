// Providers //

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=2.4.1"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">=1.14.0"
    }
  }
}