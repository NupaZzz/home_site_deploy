provider "docker" {
  host            = var.docker_host
  # host            = "tcp://localhost:2375"

  registry_auth {
    address       = var.docker_reg
    username      = var.owner
    password      = var.git_token
  }
}