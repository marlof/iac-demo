# Create API service
resource "kubernetes_service" "words" {
    metadata {
        name = "words"
        labels = {
            app = "words-api"
        }
    }

    spec {
        selector = {
            app = "words-api"
        }
        port {
            port = 8080
            target_port = 8080
            name = "words"
        }

        cluster_ip = "None"
    }
}

# Create API deployment
resource "kubernetes_deployment" "words" {
    metadata {
        name = "words"
        labels = {
            app = "words-api"
        }
    }

    spec {
        replicas = 3

        selector {
            match_labels = {
                app = "words-api"
            }
        }


        template {
            metadata {
                labels = {
                    app = "words-api"
                }
            }

            spec {
                container {
                    image = "dockersamples/k8s-wordsmith-api"
                    name = "api"
                    port {
                        container_port = 8080
                        name = "words"
                    }
                }
            }
        }
    }
}