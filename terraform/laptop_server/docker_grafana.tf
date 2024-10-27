resource "docker_image" "grafana" {
  name = "${var.grafana_container_name}/${var.grafana_container_name}:${var.grafana_tag}"
}

resource "null_resource" "grafana_remove_existing_container" {
  provisioner "local-exec" {
    command = "docker rm -f ${var.grafana_container_name}|| true"
  }
}

resource "docker_container" "grafana" {
  depends_on = [null_resource.grafana_remove_existing_container]
  provider   = docker.laptop_server

  image = docker_image.grafana.image_id
  name  = var.grafana_container_name
  ports {
    internal = var.grafana_internal_port
    external = var.grafana_external_port
  }

  networks_advanced {
    name         = var.docker_app_network
    ipv4_address = var.grafana_container_ip
  }

  volumes {
    container_path = var.grafana_container_path
    host_path      = var.grafana_host_path
  }
}

resource "null_resource" "configure_grafana" {
  depends_on = [docker_container.grafana]

  provisioner "local-exec" {
    command = <<EOT
      sleep 10
      curl -X POST http://admin:admin@localhost:3000/api/datasources \
        -H "Content-Type: application/json" \
        -d '{
          "name": "Prometheus",
          "type": "prometheus",
          "url": "http://${var.prom_container_ip}:${var.prom_external_port}",
          "access": "proxy",
          "basicAuth": false
        }'
    EOT
  }
}
