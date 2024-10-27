resource "docker_image" "prometheus" {
  name = "${var.prom_image_name}:${var.prom_image_tag}"
}

resource "null_resource" "prom_remove_existing_container" {
  provisioner "local-exec" {
    command = "docker rm -f ${var.prom_container_name} || true"
  }
}

resource "null_resource" "remove_existing_image_prom" {
  provisioner "local-exec" {
    command = "docker rmi -f ${var.prom_image_name} || true"
  }
}

resource "docker_container" "prometheus" {
  depends_on = [null_resource.prom_remove_existing_container]
  provider   = docker.laptop_server

  image = docker_image.prometheus.image_id
  name  = var.prom_container_name

  ports {
    internal = var.prom_internal_port
    external = var.prom_external_port
  }

  volumes {
    container_path = "/etc/prometheus/prometheus.yml"
    host_path      = "/opt/project_site/prometheus.yml"
  }

  networks_advanced {
    name         = var.docker_app_network
    ipv4_address = var.prom_container_ip
  }
}

resource "local_file" "prometheus_config" {
  content  = <<EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: '${var.docker_name}'
    static_configs:
      - targets: ['${var.app_container_ip}:${var.port}']

  - job_name: 'node_exporter'
      static_configs:
        - targets: ['172.18.0.14:9100']
EOF
  filename = "/opt/project_site/prometheus.yml"
}
