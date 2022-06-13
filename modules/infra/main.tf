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

// Kubernetes Configuration
data "aws_eks_cluster" "eks_cluster" {
  depends_on = [aws_eks_cluster.eks_cluster]
  name = "${var.env_name}_${var.env_id}"
}

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  depends_on = [aws_eks_cluster.eks_cluster]
  name = "${var.env_name}_${var.env_id}"
}
