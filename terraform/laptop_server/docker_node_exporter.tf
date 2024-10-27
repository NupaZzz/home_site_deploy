resource "docker_image" "node_exporter" {
  name = "${var.node_exporter_image_name}:${var.node_exporter_tag}"
}

resource "null_resource" "node_exporter_remove_existing_container" {
  provisioner "local-exec" {
    command = "docker rm -f ${var.node_exporter_container_name} || true"
  }
}

resource "docker_container" "node_exporter" {
  depends_on = [null_resource.node_exporter_remove_existing_container]
  provider   = docker.laptop_server

  image = docker_image.node_exporter.image_id
  name  = var.node_exporter_container_name
  ports {
    internal = var.node_exporter_internal_port
    external = var.node_exporter_external_port
  }

  networks_advanced {
    name         = var.docker_app_network
    ipv4_address = var.node_exporter_container_ip
  }
}