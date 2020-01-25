# Configure provider
provider "google" {
  credentials = file("../../../terraform-test.json")

  project = "spoved-iac-demo"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# User/pass for k8s cluster
variable "pw" {}
variable "un" {}


resource "google_container_cluster" "gke-cluster" {
  name               = "spoved-iac-demo-cluster"
  network            = "default"
  initial_node_count = 3

  master_auth {
    username = var.un
    password = var.pw
  }
}


output "client_cert" {
  value     = "${google_container_cluster.gke-cluster.master_auth.0.client_certificate}"
  sensitive = true
}

output "client_key" {
  value     = "${google_container_cluster.gke-cluster.master_auth.0.client_key}"
  sensitive = true
}

output "cluster_ca_cert" {
  value     = "${google_container_cluster.gke-cluster.master_auth.0.cluster_ca_certificate}"
  sensitive = true
}

output "endpoint" {
  value     = "${google_container_cluster.gke-cluster.endpoint}"
  sensitive = true
}
