resource "local_file" "ssh_config" {
  filename = "./ssh_config"
  content = templatefile("ssh_config.j2", {
    instance_id = {
        master = aws_instance.master.id,
    }
  })
}
