/////////////
// Outputs //
/////////////

// FTD management IP address to access UI //
output "ftd_mgmt_ip" {
  value = aws_eip.ftd_mgmt_EIP.public_ip
}

// Public IP address of EKS node to access web apps //
output "eks_public_ip" {
  value = aws_eip.eks_outside_EIP.public_ip
}

// EKS Cluster name
output "eks_cluster_name" {
  value = "${var.env_name}_${var.env_id}"
}

// EKS Cluster API Endpoint
output "eks_cluster_api_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

// EKS Cluster Certificate Authority
output "eks_cluster_ca" {
  value = data.aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

// EKS Cluster Auth Token
output "eks_cluster_auth_token" {
  value = data.aws_eks_cluster_auth.eks_cluster_auth.token
}

// EKS Cluster ARN (Kubeconfig Context name)
output "eks_cluster_arn" {
  value = data.aws_eks_cluster.eks_cluster.arn
}