resource "docker_image" "my_app" {
  name            = "${var.docker_reg}/${var.lower_login}/${var.image_name}:${var.image_tag}"
  keep_locally    = false
}

resource "null_resource" "remove_existing_container" {
  provisioner "local-exec" {
    command       = "docker rm -f ${var.docker_name} || true"
  }
}

resource "null_resource" "remove_existing_image" {
  provisioner "local-exec" {
    command       = "docker rmi -f ${var.docker_reg}/${var.lower_login}/${var.image_name}:${var.image_tag} || true"
  }
}

resource "docker_container" "my_app" {
  depends_on = [null_resource.remove_existing_container]

  image           = docker_image.my_app.name
  name            = var.docker_name
  hostname        = var.docker_name
  restart         = var.container_restart

  healthcheck {
    test          = ["CMD-SHELL", "curl -f http://${var.app_ip}:${var.port}"]
    interval      = var.health_interval
    timeout       = var.health_timeout
    retries       = var.health_retries
    start_period  = var.health_start_period
  }
  
  ports {
    internal      = var.port
    external      = var.port
  }

  volumes {
    host_path      = var.host_volume_path
    container_path = var.container_volume_path
  }

  networks_advanced {
    name           = var.docker_app_network
    ipv4_address   = var.app_container_ip
  }
}
