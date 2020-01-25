variable "un" {
  default = "admin-user"
}
variable "pw" {
  default = "averycomplicatedpassword"
}

module "cluster" {
  source   = "./cluster"
  un = var.un
  pw = var.pw
}

#module "app" {
#  source   = "./app"
#  host     = module.cluster.endpoint
#  un = var.un
#  pw = var.pw
#
#  client_cert     = module.cluster.client_cert
#  client_key      = module.cluster.client_key
#  cluster_ca_cert = module.cluster.cluster_ca_cert
#}