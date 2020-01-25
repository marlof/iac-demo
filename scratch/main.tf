provider "google" {
  credentials = file("../terraform-test.json")

  project = "spoved-iac-demo"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

