resource "ssh_resource" "deploy_container" {
  provisioner "remote-exec" {
    host        = "192.168.100.7"
    user        = "Arinka"
    private_key = file("/home/asus/.ssh/id_rsa")
    timeout     = "1m"

    commands = [
      "docker run -d -p 8080:80 --name nginx nginx:latest"
    ]
  }
}
