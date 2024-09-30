provider "null" {}

resource "null_resource" "deploy_container" {
  provisioner "remote-exec" {
    inline = [
      "docker run -d -p 8080:80 --name nginx nginx:latest"
    ]

    connection {
      type        = "ssh"
      host        = "192.168.100.7"
      user        = "Arinka"
      private_key = file("/root/.ssh/id_rsa")
    }
  }
}
