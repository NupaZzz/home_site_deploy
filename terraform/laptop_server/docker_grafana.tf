resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}

resource "null_resource" "grafana_remove_existing_container" {
  provisioner "local-exec" {
    command = "docker rm -f grafana || true"
  }
}

resource "null_resource" "remove_existing_image_grafana" {
  provisioner "local-exec" {
    command = "docker rmi -f grafana || true"
  }
}

resource "docker_container" "grafana" {
  depends_on = [null_resource.grafana_remove_existing_container]
  provider   = docker.laptop_server

  image = docker_image.grafana.image_id
  name  = "grafana"
  ports {
    internal = 3000
    external = 3000
  }

  networks_advanced {
    name         = var.docker_app_network
    ipv4_address = "172.18.0.13"
  }

  volumes {
    container_path = "/var/lib/grafana"
    host_path      = "/opt/project_site/grafana" # Укажите путь для хранения данных Grafana
  }
}
