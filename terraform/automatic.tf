provider "null" {}

resource "null_resource" "docker_container" {
  provisioner "remote-exec" {
    inline = [
      "docker pull nginx:latest",
      "docker run -d --name nginx nginx:latest"
    ]

    connection {
      type        = "ssh"
      host        = "192.168.100.7"
      user        = "Arinka"
      private_key = file("/home/asus/.ssh/id_rsa")
    }
  }
}