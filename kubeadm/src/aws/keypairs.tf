// ssh keyを置くディレクトリー
variable "ssh_keys" {
  type = string
  default = "./"
}

resource "null_resource" "ssh-keygen" {
  provisioner "local-exec" {
    command = "ssh-keygen -m PEM  -C '' -N '' -f ${var.ssh_keys}/id_rsa; exit 0"
  }
}

data "local_file" "ssh-keygen" {
  filename   = "${var.ssh_keys}/id_rsa.pub"
  depends_on = [ null_resource.ssh-keygen ]
}

resource "aws_key_pair" "keypair" {
  key_name = "keypair"
  public_key = data.local_file.ssh-keygen.content
}

output "pub_key" {
  value = data.local_file.ssh-keygen.content
}
