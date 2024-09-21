resource "ssh_resource" "default_server" {
  host = var.public_ip

  connection {
    host        = var.public_ip
    user        = var.ssh_username
    private_key = file(var.ssh_private_key)
    agent       = false
  }

  provisioner "remote-exec" {
    inline = concat(
      [for item in var.repositories :
        "echo ${item.name}; cd ${var.server_root}; git clone ${item.url}; cd ${var.server_root}/${item.name}; ${item.command}"
      ]
    )
  }

  provisioner "file" {
    source      = "./config/core/config.production.yaml"
    destination = "/root/Kavka-Core/config/config.production.yaml"
  }

  provisioner "file" {
    source      = "./config/web/environment.production.ts"
    destination = "/root/Kavka-Web/src/environments/environment.production.ts"
  }
}

