provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "web-vpc" {
  cidr_block = "10.1.0.0/24"
  tags = {
    name = "web"
  }
}
resource "aws_subnet" "web-subnet" {
  vpc_id                  = aws_vpc.web-vpc.id
  cidr_block              = "10.1.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    name = "web"
  }
}

resource "aws_network_interface" "web" {
  subnet_id   = aws_subnet.web-subnet.id
  private_ips = ["10.1.0.10"]
  tags = {
    name = "web"
  }
}

resource "aws_ebs_volume" "ebs-1" {
  availability_zone = "ap-south-1a"
  size              = 8
  type              = "gp3"
  tags = {
    name = "web"
  }
}

resource "aws_ebs_volume" "ebs-2" {
  availability_zone = "ap-south-1a"
  size              = 8
  type              = "gp3"
  tags = {
    name = "web"
  }
}

resource "aws_instance" "web" {
  ami                  = "ami-09b0a86a2c84101e1"
  instance_type        = "t2.micro"
  iam_instance_profile = "AWS_SSM_ROLE"
  availability_zone    = "ap-south-1a"
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp3"
    volume_size = "8"
  }
  network_interface {
    network_interface_id = aws_network_interface.web.id
    device_index         = 0
  }
  tags = {
    name = "web"
  }
}

resource "aws_volume_attachment" "web-ebs-1" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs-1.id
  instance_id = aws_instance.web.id
}

resource "aws_volume_attachment" "web-ebs-2" {
  device_name = "/dev/sda2"
  volume_id   = aws_ebs_volume.ebs-2.id
  instance_id = aws_instance.web.id
}

