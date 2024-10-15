provider "aws" {
  region = var.region
}

/*resource "aws_key_pair" "web-key" {
  key_name   = var.key_name
  public_key = file("/root/.ssh/terraform-key.pub")
}*/

resource "aws_instance" "web" {
  ami                  = var.ami
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_instance_profile
  availability_zone    = var.availability_zone
  key_name             = var.key_name
  # vpc_id = aws_vpc.web-vpc.id
  subnet_id              = aws_subnet.web-public-1-subnet.id
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp3"
    volume_size = var.volume_size
  }
  #network_interface {
  #  network_interface_id = aws_network_interface.web.id
  #  device_index         = 0
  #}
  tags = {
    name = "web"
  }
}
/*data "aws_key_pair" "web" {
  key_name           = var.key_name
  include_public_key = true
}
output "web-key" {
  value = data.aws_key_pair.web.key_name
}*/
