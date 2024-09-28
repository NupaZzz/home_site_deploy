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
  image = docker_image.pihole.name
  name  = var.pihole_container_name
  restart = "unless-stopped"
  depends_on = [docker_image.pihole]

  ports {
    internal = 53
    external = 5354
    protocol = "tcp"
  }

  ports {
    internal = 53
    external = 5354
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
    "WEBPASSWORD=1234567890abcdef",
    "DNSMASQ_LISTENING=all",
    "DNS_FQDN_REQUIRED=true",
    "DNS_BOGUS_PRIV=true",
    "DNSSEC=true",
    "PIHOLE_DNS_=1.1.1.1;1.0.0.1"
  ]

  capabilities {
    add = ["NET_ADMIN"]
  }

  memory = 256 * 1024 * 1024
  cpu_shares = 512

  volumes {
    host_path      = "/opt/terraform/scripts/adlists.sh"
    container_path = "/etc/cont-init.d/10-adlists.sh"
  }

  networks_advanced {
    name           = var.docker_app_network
    ipv4_address   = var.pihole_container_ip
  }
}
