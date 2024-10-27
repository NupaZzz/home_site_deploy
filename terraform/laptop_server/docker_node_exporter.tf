resource "docker_image" "node_exporter" {
  name = "node_exporter:latest"
}

resource "null_resource" "node_exporter_remove_existing_container" {
  provisioner "local-exec" {
    command = "docker rm -f node_exporter || true"
  }
}

resource "docker_container" "node_exporter" {
  depends_on = [null_resource.node_exporter_remove_existing_container]
  provider   = docker.laptop_server

  image = docker_image.node_exporter.image_id
  name  = "node_exporter"
  ports {
    internal = 9100
    external = 9100
  }

  networks_advanced {
    name         = var.docker_app_network
    ipv4_address = "172.18.0.14"
  }
}