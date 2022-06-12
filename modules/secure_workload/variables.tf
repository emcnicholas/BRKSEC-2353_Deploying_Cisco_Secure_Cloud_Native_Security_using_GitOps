variable "secure_workload_api_key" {
  description = "Secure Workload API Key"
}
variable "secure_workload_api_sec" {
  description = "Secure Workload API Secret"
}
variable "secure_workload_api_url" {
  description = "Secure Workload URL ex: https://FQDN"
}
variable "secure_workload_root_scope" {
  description = "The ID of the Secure Workload Root Scope"
}
variable "eks_cluster_name" {
  description = "Name of the AWS EKS Cluster"
}
variable "env_id" {
  description = "An unique ID assigned to the environment"
}