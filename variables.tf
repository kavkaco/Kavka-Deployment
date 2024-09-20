variable "public_ip" {
  description = "Public ip address of the server"
}

variable "ssh_username" {
  description = "Username of the ssh server"
  default     = "root"
}

variable "ssh_private_key" {
  description = "Private key of the ssh server"
  type        = string
}

variable "server_root" {
  description = "The base directory that project repositories would be cloned there"
  type        = string
  default     = "/root"
}

variable "build_core" {
  default = [
    "screenfetch"
    # "docker-compose up -d"
  ]
}
