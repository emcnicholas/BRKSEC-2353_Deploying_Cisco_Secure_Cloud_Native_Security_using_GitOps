###########
# Variables
###########
variable "appd_url" {
  description = "URL of the Appd SaaS instance ex: https://mycompany.saas.appdynamics.com"
  type        = string
  sensitive   = true
}
variable "appd_account_name" {
  description = "Name of the AppD Account (can be found at Settings > License > Account Details > Name"
  type        = string
  sensitive   = true
}
variable "appd_username" {
  description = "DevNet AppDynamics controller username"
  type        = string
  sensitive   = true
}
variable "appd_password" {
  description = "DevNet AppDynamics controller password"
  type        = string
  sensitive   = true
}
variable "appd_accessKey" {
  description = "AppD Access Key (can be found at Settings > License > Account Details > Access Key"
  type        = string
  sensitive   = true
}