####################-Create Private Server-#######################
resource "aws_instance" "apache_server" {
  ami                    = "ami-070beac973323ac97"
  instance_type          = "t2.micro"
  key_name               = "Server"
  vpc_security_group_ids = [aws_security_group.private_server_sg.id]
  subnet_id              = aws_subnet.private_subnet.id
  iam_instance_profile   = aws_iam_instance_profile.e_instance_profile_server.name
  tags = {
    Name = "${var.project}-Server"
  }
}

####################-Create Bastion Host-#######################
resource "aws_instance" "bastion_host" {
  ami                    = "ami-0d9efc67b4e551155"
  instance_type          = "t2.micro"
  key_name               = "BastionHost"
  vpc_security_group_ids = [aws_security_group.bastion_host_sg.id]
  subnet_id              = aws_subnet.public_subnet_a.id
  iam_instance_profile   = aws_iam_instance_profile.e_instance_profile_proxy.name
  user_data              = <<-EOF
                              #!/bin/bash
                              sudo yum update -y
                              sudo yum install squid -y
                              sudo systemctl start squid
                              sudo systemctl enable squid
                              sudo aws s3 cp s3://ec2.cvh/squid.conf /etc/squid/
                              sudo systemctl restart squid
                              EOF
  tags = {
    Name = "Bastion-Host-Server"
  }
}

####################-Create IP Public Bastion Host-#######################
resource "aws_eip" "eip" {
  vpc      = true
  instance = aws_instance.bastion_host.id
}