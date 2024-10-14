/*resource "aws_ebs_volume" "ebs-1" {
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
}*/

/*resource "aws_volume_attachment" "web-ebs-1" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs-1.id
  instance_id = aws_instance.web.id
}

resource "aws_volume_attachment" "web-ebs-2" {
  device_name = "/dev/sda2"
  volume_id   = aws_ebs_volume.ebs-2.id
  instance_id = aws_instance.web.id
}
*/
