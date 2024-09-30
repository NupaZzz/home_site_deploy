resource "null_resource" "remove_pihole_container" {
  provisioner "local-exec" {
    command = "docker rm -f pihole || true"
  }
}

resource "null_resource" "remove_pihole_image" {
  provisioner "local-exec" {
    command = "docker rmi pihole/pihole:latest || true"
  }
  depends_on = [null_resource.remove_pihole_container]
}

resource "docker_image" "pihole" {
  name = "pihole/pihole:latest"
  depends_on = [null_resource.remove_pihole_image]
}

resource "docker_container" "pihole" {
  image       = docker_image.pihole.name
  name        = var.pihole_container_name
  restart     = "unless-stopped"
  depends_on  = [docker_image.pihole]
  hostname    = "home_site"

  ports {
    internal = 53
    external = 53
    protocol = "tcp"
  }

  ports {
    internal = 53
    external = 53
    protocol = "udp"
  }

  ports {
    internal = 67
    external = 67
    protocol = "udp"
  }

  ports {
    internal = 80
    external = 80
    protocol = "tcp"
  }

  env = [
    "TZ=Europe/Minsk",
    "WEBPASSWORD=${var.pihole_web_password}",
    "DNSMASQ_LISTENING=single",
    "DNS_FQDN_REQUIRED=true",
    "DNS_BOGUS_PRIV=true",
    "DNSSEC=${var.pihole_dnssec}",
    "PIHOLE_DNS_=${var.pihole_dns}",
    "WEBTHEME=default-darker"
  ]

  capabilities {
    add = ["NET_ADMIN"]
  }

  memory = 256 * 1024 * 1024
  cpu_shares = 512

  volumes {
    host_path      = var.pihole_volumes_host
    container_path = var.pihole_volumes_docker
  }

  networks_advanced {
    name           = var.docker_app_network
    ipv4_address   = var.pihole_container_ip
  }
}
