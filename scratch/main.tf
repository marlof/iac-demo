# Configure provider
provider "google" {
  credentials = file("../terraform-test.json")

  project = "spoved-iac-demo"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# User/pass for k8s cluster
variable "pw" {
  default = "acomplicatedpassword"
}
variable "un" {
  default = "k8s-admin"
}

resource "google_container_cluster" "gke-cluster" {
  name               = "spoved-iac-demo-cluster"
  network            = "default"
  initial_node_count = 3

  master_auth {
    username = var.un
    password = var.pw
  }

}