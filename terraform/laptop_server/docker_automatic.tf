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

  ports {
    internal = 7860
    external = 7860
  }
}
