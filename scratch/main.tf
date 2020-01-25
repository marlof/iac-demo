provider "google" {
  credentials = file("../terraform-test.json")

  project = "spoved-iac-demo"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_container_cluster" "gke-cluster" {
  name               = "spoved-iac-demo-cluster"
  network            = "default"
  location           = "europe-west1-b"
  initial_node_count = 3
}