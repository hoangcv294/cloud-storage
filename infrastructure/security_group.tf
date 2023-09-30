#######################-Create SG Server-#######################
resource "aws_security_group" "private_server_sg" {
  name        = "${var.project}-Server"
  description = "Allow BH-ALB"

  vpc_id = aws_vpc.cloud_storage_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.240.1.0/25"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.240.1.0/26"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private Security"
  }
}

#######################-Create SG Bastion-Host-#######################
resource "aws_security_group" "bastion_host_sg" {
  name        = "Bastion-Host-SG"
  description = "Method Connection"

  vpc_id = aws_vpc.cloud_storage_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["113.160.224.161/32"]
    description = "dev-ssh"
  }

  ingress {
    from_port   = 3128
    to_port     = 3128
    protocol    = "tcp"
    cidr_blocks = ["113.160.224.161/32"]
    description = "dev-proxy"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  tags = {
    Name = "Bastion-Host"
  }
}

#######################-Create SG ALB-#######################
resource "aws_security_group" "cloud_storage_sg" {
  name        = "${var.project}-SG"
  description = "All Traffic"

  vpc_id = aws_vpc.cloud_storage_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["18.141.21.71/32"]
    description = "bastions-host"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-SG"
  }
}