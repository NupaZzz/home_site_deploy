provider "docker" {
  alias = "laptop_server"
  host  = var.docker_host

  registry_auth {
    address  = var.docker_reg
    username = var.owner
    password = var.git_token
  }
}

provider "docker" {
  alias = "desktop_server"
  host  = "tcp://192.168.100.7:2375"

  registry_auth {
    address  = var.docker_reg
    username = var.owner
    password = var.git_token
  }
}
