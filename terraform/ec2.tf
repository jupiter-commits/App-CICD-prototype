locals {
  key_name      = "developer-key-1"
  eu_west_3_ami = "ami-0b198a85d03bfa122"
  ssh_user      = "ec2-user"
  private_key_path = ""
}

resource "aws_key_pair" "developer" {
  key_name   = local.key_name
  public_key = var.public_key_1
}


resource "aws_instance" "public_server_docker" {
  ami             = locals.eu_west_3_ami
  instance_type   = var.instance_type
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.public_subnet.name]
  key_name        = local.key_name


  provisioner "remote-exec" {
    inline = ["echo 'server is running' "]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.public_ip
    }

  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.public_ip}, --private-key ${key_name}  ../ansible/main.yml"
  }


  tags = {
    Name = "Public EC2 server for application and containers , configured by ansible"
  }
}

resource "aws_instance" "public_server_jenkins" {
  ami             = locals.eu_west_3_ami
  instance_type   = var.instance_type
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.public_subnet.name]
  key_name        = local.key_name


  provisioner "remote-exec" {
    inline = ["echo 'server is running' "]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.public_ip
    }

  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.public_ip}, --private-key ${key_name}  ../ansible/main.yml"
  }


  tags = {
    Name = "Public EC2 server 2 for Jenkins , configured by ansible"
  }
}