// Main //

// Deploy the Infrastructure
module "Infrastructure" {
  source = "./modules/infra"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  region         = var.region
  ftd_user       = var.ftd_user
  ftd_pass       = var.ftd_pass
  env_name       = var.env_name
  env_id         = var.env_id
  aws_az1        = var.aws_az1
  aws_az2        = var.aws_az2
  key_name       = var.key_name
}

// Update AWS EKS Kubeconfig
resource "null_resource" "update_kubeconfig" {
  depends_on = [module.Infrastructure]
  provisioner "local-exec" {
      working_dir = path.module
      command = "aws eks --region ${var.region} update-kubeconfig --name ${module.Infrastructure.eks_cluster_name}"
  }
}

// Deploy Secure Cloud Analytics
module "Secure_Cloud_Analytics" {
  depends_on      = [module.Infrastructure]
  source          = "./modules/secure_cloud_analytics"
  sca_service_key = var.sca_service_key
}

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
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.2.0"
    }
  }
}
provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region     =  var.region
}

provider "kubernetes" {
  host                   = module.Infrastructure.eks_cluster_api_endpoint
  cluster_ca_certificate = base64decode(module.Infrastructure.eks_cluster_ca)
  token                  = module.Infrastructure.eks_cluster_auth_token
  //load_config_file       = false
}

provider "kubectl" {
  host                   = module.Infrastructure.eks_cluster_api_endpoint
  cluster_ca_certificate = base64decode(module.Infrastructure.eks_cluster_ca)
  token                  = module.Infrastructure.eks_cluster_auth_token
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = module.Infrastructure.eks_cluster_api_endpoint
    cluster_ca_certificate = base64decode(module.Infrastructure.eks_cluster_ca)
    token                  = module.Infrastructure.eks_cluster_auth_token
  }
}

