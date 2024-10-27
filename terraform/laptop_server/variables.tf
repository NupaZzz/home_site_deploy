variable "owner" {
  description = "GitHub owner or organization name"
  type        = string
}

variable "image_name" {
  description = "Docker image name"
  type        = string
}

variable "image_tag" {
  description = "Tag for the Docker image"
  type        = string
}

variable "git_token" {
  description = "GitHub token for authentication"
  type        = string
  sensitive   = true
}

variable "lower_login" {
  description = "Github username for docker"
  type        = string
}

variable "port" {
  description = "Port for container"
  type        = number
}

variable "docker_name" {
  description = "Container name"
  type        = string
}

variable "docker_reg" {
  description = "Docker registry"
  type        = string
}

variable "container_volume_path" {
  description = "Volume path into container"
  type        = string
}

variable "host_volume_path" {
  description = "Volume path on host"
  type        = string
}

variable "health_interval" {
  description = "Interval for health check"
  type        = string
}

variable "health_timeout" {
  description = "Timeout for health check"
  type        = string
}

variable "health_retries" {
  description = "Number of retries for health check"
  type        = number
}

variable "health_start_period" {
  description = "Start period for health check"
  type        = string
}

variable "container_restart" {
  description = "Restart policy for container"
  type        = string
}

variable "docker_host" {
  description = "Docker host"
  type        = string
}

variable "app_ip" {
  description = "IP address of the application"
  type        = string
}

variable "prom_image_name" {
  description = "Prometheus image name"
  type        = string
}

variable "prom_image_tag" {
  description = "Prometheus image tag"
  type        = string
}

variable "prom_internal_port" {
  description = "Internal port for Prometheus"
  type        = number
}

variable "prom_external_port" {
  description = "External port for Prometheus"
  type        = number
}

variable "prom_container_name" {
  description = "Prometheus container name"
  type        = string
}

variable "app_container_ip" {
  description = "IP address of the application container"
  type        = string
}

variable "prom_container_ip" {
  description = "IP address of the Prometheus container"
  type        = string
}

variable "docker_app_network" {
  description = "Docker network name"
  type        = string
}

variable "docker_driver" {
  description = "Docker network driver"
  type        = string
}

variable "docker_subnet" {
  description = "Docker network subnet"
  type        = string
}

variable "pihole_container_name" {
  description = "Name of the pihole container"
  type        = string
}

variable "pihole_container_ip" {
  description = "IP address of the pihole container"
  type        = string
}

variable "pihole_web_password" {
  description = "Password for the pihole web interface"
  sensitive   = true
  type        = string
}

variable "pihole_dns" {
  description = "DNS server for the pihole"
  type        = string
}

variable "pihole_dnssec" {
  description = "DNSSEC configuration for the pihole"
  type        = bool
}

variable "pihole_volumes_host" {
  description = "Host path for the pihole volumes"
  type        = string
}

variable "pihole_volumes_docker" {
  description = "Container path for the pihole volumes"
  type        = string
}

variable "pihole_tag" {
  description = "Tag for the pihole image"
  type        = string
}

variable "pihole_docker_ram" {
  description = "RAM limit for the pihole container"
  type        = number
}

variable "pihole_docker_cpu" {
  description = "CPU limit for the pihole container"
  type        = number
}

variable "pihole_http_port_ext" {
  description = "External port for the pihole HTTP server"
  type        = number
}

variable "pihole_http_port_in" {
  description = "Internal port for the pihole HTTP server"
  type        = number
}

variable "pihole_dns_port_ext" {
  description = "External port for the pihole DNS server"
  type        = number
}

variable "pihole_dns_port_in" {
  description = "Internal port for the pihole DNS server"
  type        = number
}

variable "pihole_dhcp_port_ext" {
  description = "External port for the pihole DHCP server"
  type        = number
}

variable "pihole_dhcp_port_in" {
  description = "Internal port for the pihole DHCP server"
  type        = number
}

variable "grafana_container_name" {
  description = "Name of the grafana container"
  type        = string
}

variable "grafana_tag" {
  description = "Tag of the grafana image"
  type        = string
}

variable "grafana_internal_port" {
  description = "Internal port for the grafana server"
  type        = number
}

variable "grafana_external_port" {
  description = "External port for the grafana server"
  type        = number
}

variable "grafana_container_ip" {
  description = "IP address of the grafana container"
  type        = string
}

variable "grafana_host_path" {
  description = "Path to the grafana host directory"
  type        = string
}

variable "grafana_container_path" {
  description = "Path to the grafana container directory"
  type        = string
}