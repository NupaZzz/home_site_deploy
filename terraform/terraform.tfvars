### DOCKER VARS ###
owner                   = "NupaZzz"
image_name              = "app"
image_tag               = "latest"
port                    = "8080"
docker_name             = "home_site"
lower_login             = "nupazzz"
docker_reg              = "ghcr.io"
container_volume_path   = "/app/data"
host_volume_path        = "/opt/project_site/data"
health_interval         = "30s"
health_timeout          = "10s"
health_retries          = 3
health_start_period     = "30s"
container_restart       = "always"
docker_host             = "unix:///var/run/docker.sock"
app_ip                  = "localhost"
app_container_ip        = "172.18.0.10"

### PROMETHEUS VARS ###
prom_image_name         = "prom/prometheus"
prom_image_tag          = "latest"
prom_internal_port      = "9090"
prom_external_port      = "9090"
prom_container_name     = "prometheus"
prom_container_ip       = "172.18.0.11"

### DOCKER NETWORKD ###
docker_app_network       = "app_network"
docker_driver            = "bridge"
docker_subnet            = "172.18.0.0/16"

### PIHOLE VARS ###
pihole_container_name   = "pihole"
pihole_container_ip     = "172.18.0.12"
pihole_dns              = "1.1.1.1;1.0.0.1"
pihole_dnssec           = "true"