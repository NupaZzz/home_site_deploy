data "docker_network" "app_network" {
  name = var.docker_app_network
}

resource "docker_network" "app_network" {
  count = length(data.docker_network.app_network.id) == 0 ? 1 : 0
  name   = var.docker_app_network
  driver = var.docker_driver

  ipam_config {
    subnet = var.docker_subnet
  }
}