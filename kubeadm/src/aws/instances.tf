data "aws_iam_instance_profile" "ssmrole" {
  name = "AmazonSSMRoleForInstancesQuickSetup"
}

resource "aws_instance" "kubernetes" {
  ami           = "ami-07c589821f2b353aa"
  instance_type = "t3a.small"
  subnet_id     = aws_subnet.private_subnet.id
  iam_instance_profile = data.aws_iam_instance_profile.ssmrole.name
  key_name = aws_key_pair.keypair.key_name

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_instance" "worker" {
  ami           = "ami-07c589821f2b353aa"
  instance_type = "t3a.small"
  subnet_id     = aws_subnet.private_subnet.id
  iam_instance_profile = data.aws_iam_instance_profile.ssmrole.name
  key_name = aws_key_pair.keypair.key_name

  tags = {
    Name = "worker"
  }
}

output "kubernetes" {
  value = aws_instance.kubernetes.id
}

output "worker" {
  value = aws_instance.worker.id
}
