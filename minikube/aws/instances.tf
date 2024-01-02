data "aws_iam_instance_profile" "ssmrole" {
  name = "AmazonSSMRoleForInstancesQuickSetup"
}

resource "aws_security_group" "master" {
  vpc_id = aws_vpc.main.id
  name = "master"
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
  security_group_id = aws_security_group.master.id
}

resource "aws_instance" "master" {
  ami           = "ami-07c589821f2b353aa"
  instance_type = "t3a.small"
  subnet_id     = aws_subnet.public_subnet.id
  iam_instance_profile = data.aws_iam_instance_profile.ssmrole.name
  key_name = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.master.id]

  tags = {
    Name = "master"
  }
}

output "master" {
  value = aws_instance.master.id
}
