resource "docker_image" "pihole" {
  name = "pihole/pihole:latest"
}

resource "docker_container" "pihole" {
  image = docker_image.pihole.name
  name  = "pihole"
  restart = "unless-stopped"

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
    host_path      = "/opt/scripts/adlists.sh"
    container_path = "/etc/cont-init.d/10-adlists.sh"
  }
}
