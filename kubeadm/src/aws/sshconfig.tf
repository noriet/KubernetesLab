resource "local_file" "ssh_config" {
  filename = "./ssh_config"
  content = templatefile("ssh_config.j2", {
    instance_id = {
        kubernetes = aws_instance.kubernetes.id,
        worker = aws_instance.worker.id
    }
  })
}
