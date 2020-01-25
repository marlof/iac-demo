# Create a DB service, no cluster IP needed
resource "kubernetes_service" "db" {
    metadata {
        name = "db"
        labels = {
            app = "words-db"
        }
    }

    spec {
        selector = {
            app = "words-db"
        }

        port {
            port = 5432
            target_port = 5432
            name = "db"
        }

        cluster_ip = "None"
    }
}

# Create DB deployment
resource "kubernetes_deployment" "db" {
  metadata {
    name = "db"
    labels = {
        app = "words-db"
    }
  }

  spec {

    selector {
        match_labels = {
            app = "words-db"
        }
    }

    template {
      metadata {
        labels = {
          app = "words-db"
        }
      }

      spec {
        container {
          image = "dockersamples/k8s-wordsmith-db"
          name  = "db"
          port {
              container_port = 5432
              name = "db"
          }
        }
      }
    }
  }
}