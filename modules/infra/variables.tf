// Variables //
variable "aws_access_key" {
  description = "AWS Access Key"
}
variable "aws_secret_key" {
  description = "AWS Secret Key"
}
variable "region" {
  description = "AWS Region ex: us-east-1"
}
variable "FTD_version" {
  description = "Secure Firewall Version"
  default = "ftdv-6.7.0"
}
variable "ftd_user" {
  description = "Secure Firewall Username"
  default = "admin"
}
variable "ftd_pass" {
  description = "Secure Firewall Password"
}
variable "env_name" {
  description = "name associated with this environment"
}
variable "env_id" {
  description = "ID associated with this environment"
}
//AWS Availability Zones
variable "aws_az1" {
  description = "AWS Availability Zone 1 ex: us-east-1a"
}
variable "aws_az2" {
  description = "AWS Availability Zone 2 ex: us-east-1b"
}
variable "vpc_cidr" {
  description = "AWS VPC CIDR Block"
  default = "10.0.0.0/16"
}
//Subnet and IP addresses
variable "outside_subnet" {
  description = "Outside network between the FTD and IGW"
  default = "10.0.0.0/24"
}
variable "ftd_outside_ip_list" {
  description = "Outside and static NAT IP addresses assigned to the FTD Outside interface"
  type = list(string)
  default = ["10.0.0.10","10.0.0.11"]
}
variable "ftd_outside_ip" {
  description = "IP address assigned to the FTD Outside interface"
  default = "10.0.0.10"
}
variable "eks_outside_ip" {
  description = "IP address assigned to the EKS Node Static NAT"
  default = "10.0.0.11"
}
variable "inside_subnet" {
  description = "Internal network between the FTD and EKS Node"
  default = "10.0.1.0/24"
}
variable "ftd_inside_ip" {
  description = "IP address assigned to the FTD Inside interface"
    default = "10.0.1.10"
}
variable "mgmt_subnet" {
  description = "Management Network"
  default = "10.0.2.0/24"
}
variable "ftd_mgmt_ip" {
  description = "Ip address assigned to the FTD Management Interface"
  default = "10.0.2.10"
}
variable "diag_subnet" {
  description = "FTD Diagnostics network"
  default = "10.0.3.0/24"
}
variable "inside2_subnet" {
  description = "NOT USED - Secondary Internal network to satisfy EKS requirements"
    default = "10.0.4.0/24"
}
variable "ftd_size" {
  description = "FTD EC2 instance size"
  default = "c5.xlarge"
}
//  Existing SSH Key on the AWS
variable "key_name" {
  description = "SSH key created in AWS region this deployment is being deployed to"
}
// Remote Hosts //
variable "remote_hosts" {
  description = "Remote host permitted access to FTD Management and AWS EKS Cluster UI and API"
  default = ["0.0.0.0/0"]
}

// Local Variables used for multi-site deployments //
locals {
  eks_cluster_name = "${var.env_name}_${var.env_id}"
  vpc_name = "${var.env_name}_${var.env_id}"
  outside_ips = aws_network_interface.ftd_outside.private_ips
}