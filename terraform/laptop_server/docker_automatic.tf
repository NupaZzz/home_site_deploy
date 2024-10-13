resource "docker_container" "automatic" {
  depends_on = [null_resource.remove_existing_container_automatic]
  provider   = docker.desktop_server

  image    = docker_image.automatic.name
  name     = "automatic"
  hostname = "automatic"
  gpus     = "1"

  ports {
    internal = 7860
    external = 8081
  }

  env = [
    "COMMANDLINE_ARGS=--listen --allow-code --xformers --skip-torch-cuda-test --no-half-vae --enable-insecure-extension-access --api --theme dark --medvram --medvram-sdxl"
  ]

  volumes {
    host_path      = "C:\\Users\\Arinka\\stable-diffusion-webui\\models"
    container_path = "/stable-diffusion-webui/models"
  }
}
