# Variables used
variable un {}
variable pw {}
variable endpoint {}
variable client_cert {}
variable client_key {}
variable cluster_ca_cert {}

# Configure K8s provider
provider "kubernetes" {
  username = var.un
  password = var.pw

  host = var.endpoint
  client_certificate     = base64decode(var.client_cert)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_cert)
}
