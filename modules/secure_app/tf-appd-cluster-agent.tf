
##################################################################################
# PROVIDERS
##################################################################################
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.2.0"
    }
 }
}
resource "kubernetes_namespace" "appdynamics" {
  metadata {
    name = "appdynamics"
  }
}

resource "kubernetes_namespace" "metrics" {
  metadata {
    name = "metrics"
  }
}
# Per cluster agent requirements, we'll first need metrics-server installed.
# Comment this resource and the metrics namespace above if metrics-server
# is already installed in your environment. Also, note the extraArgs
# set in metrics-server-values.yaml and remove or readjust these values
# as needed for your environment.
#resource "helm_release" "metrics-server" {
#  name = "metrics-server"
#  namespace = "metrics"
#  repository = "https://charts.bitnami.com/bitnami"
#  chart = "metrics-server"
#}
# Deploy the AppDynamics cluster agent using AppDynamic's helm chart
resource "helm_release" "cluster-agent" {
  name = "cluster-agent"
  namespace = "appdynamics"
  repository = "https://ciscodevnet.github.io/appdynamics-charts"
  chart = "cluster-agent"

  values = [
    file("${path.module}/cluster-agent-values.yaml")
  ]
# Values below are required the cluster agent configuration file. The values are
# available in sensitive.yaml.
  set_sensitive {
    name  = "controllerInfo.url"
    value = var.appd_url
  }

  set_sensitive {
    name  = "controllerInfo.account"
    value = var.appd_account_name
  }

  set_sensitive {
    name  = "controllerInfo.username"
    value = var.appd_username
  }

  set_sensitive {
    name  = "controllerInfo.password"
    value = var.appd_password
  }

  set_sensitive {
    name  = "controllerInfo.accessKey"
    value = var.appd_accessKey
  }
}