# Variables for user/pass for k8s cluster and path to GCP creds file
variable "un" {
  type = string
  description = "User name to set for k8s cluster"
}

variable "pw" {
    type = string
    description = "Password to set for k8s cluster"
}

variable "creds" {
    type = string
    description = "Path to GCP credentials JSON file"
}


# Define k8s cluster
module "cluster" {
  source   = "./cluster"
  un = var.un
  pw = var.pw
  creds = var.creds
}

# Define db, api and front end components
module "app" {
  source   = "./app"
  un = var.un
  pw = var.pw

  endpoint        = module.cluster.endpoint
  client_cert     = module.cluster.client_cert
  client_key      = module.cluster.client_key
  cluster_ca_cert = module.cluster.cluster_ca_cert
}