resource "ssh_resource" "default_server" {
  host        = var.public_ip
  user        = var.ssh_username
  private_key = file(var.ssh_private_key)
  agent       = false

  when = "create"

  provisioner "file" {
    source      = file("./config/core/config.example.yaml")
    destination = "/root/Kavka/Kavka-Core/config/config.production.yaml"
  }

  provisioner "file" {
    source      = file("./config/web/environment.production.ts")
    destination = "/root/kavka/Kavka-Web/config/environment.production.ts"
  }

  provisioner "remote-exec" {
    inline = [
      "cd ${var.server_root}"
    ] + var.up
  }
}
