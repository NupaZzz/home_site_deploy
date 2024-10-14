resource "null_resource" "remove_pihole_container" {
  provisioner "local-exec" {
    command = "docker rm -f ${var.pihole_container_name} || true"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "remove_pihole_image" {
  provisioner "local-exec" {
    command = "docker rmi ${var.pihole_container_name}/${var.pihole_container_name}:${var.pihole_tag} || true"
  }
  depends_on = [null_resource.remove_pihole_container]
}

resource "docker_image" "pihole" {
  name       = "${var.pihole_container_name}/${var.pihole_container_name}:${var.pihole_tag}"
  depends_on = [null_resource.remove_pihole_image]
}

resource "docker_container" "pihole" {
  provider   = docker.laptop_server
  image      = docker_image.pihole.name
  name       = var.pihole_container_name
  restart    = "unless-stopped"
  depends_on = [docker_image.pihole]
  hostname   = "pihole_local"

  ports {
    internal = var.pihole_dns_port_in
    external = var.pihole_dns_port_ext
    protocol = "tcp"
  }

  ports {
    internal = var.pihole_dns_port_in
    external = var.pihole_dns_port_ext
    protocol = "udp"
  }

  ports {
    internal = var.pihole_dhcp_port_in
    external = var.pihole_dhcp_port_ext
    protocol = "udp"
  }

  ports {
    internal = var.pihole_http_port_in
    external = var.pihole_http_port_ext
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

  memory     = var.pihole_docker_ram
  cpu_shares = var.pihole_docker_cpu

  volumes {
    host_path      = var.pihole_volumes_host
    container_path = var.pihole_volumes_docker
  }

  networks_advanced {
    name         = var.docker_app_network
    ipv4_address = var.pihole_container_ip
  }
}
