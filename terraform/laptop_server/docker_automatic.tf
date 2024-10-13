resource "docker_image" "automatic" {
  name         = "${var.docker_reg}/${var.lower_login}/automatic:${var.image_tag}"
  keep_locally = false
}

resource "null_resource" "remove_existing_container_automatic" {
  provisioner "local-exec" {
    command = "docker rm -f automatic || true"
  }
}

resource "null_resource" "remove_existing_image_automatic" {
  provisioner "local-exec" {
    command = "docker rmi -f ${var.docker_reg}/${var.lower_login}/automatic:${var.image_tag} || true"
  }
}

resource "docker_container" "automatic" {
  depends_on = [null_resource.remove_existing_container_automatic]
  provider   = docker.desktop_server

  image    = docker_image.automatic.name
  name     = "automatic"
  hostname = "automatic"
  gpus     = "1"

  ports {
    internal = 7860
    external = 8081
  }

  env = [
    "COMMANDLINE_ARGS=--listen --allow-code --xformers --skip-torch-cuda-test --no-half-vae --api --theme dark --medvram --medvram-sdxl"
  ]

  volumes {
    host_path      = "C:\\Users\\Arinka\\stable-diffusion-webui\\models"
    container_path = "/stable-diffusion-webui/models"
  }

  healthcheck {
    test         = ["CMD-SHELL", "curl -f http://localhost:7860 || exit 1"]
    interval     = "30s"
    timeout      = "10s"
    retries      = 3
    start_period = "10s"
  }
}
