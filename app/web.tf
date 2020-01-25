# Create front end service
resource "kubernetes_service" "web" {
    metadata {
        name = "web"
        labels = {
            app = "words-web"
        }
    }

    spec {
        selector = {
            app = "words-web"
        }
        port {
            port = 8081
            target_port = 80
            name = "web"
        }

        type = "LoadBalancer"
    }
}

# Create front end deployment
resource "kubernetes_deployment" "web" {
    metadata {
        name = "web"
        labels = {
            app = "words-web"
        }
    }

    spec {
        replicas = 3

        selector {
            match_labels = {
                app = "words-web"
            }
        }

        template {
            metadata {
                labels = {
                    app = "words-web"
                }
            }

            spec {
                container {
                    image = "dockersamples/k8s-wordsmith-web"
                    name = "web"
                    port {
                        container_port = 80
                        name = "words-web"
                    }
                }
            }
        }
    }
}
