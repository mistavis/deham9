### Select the newest AMI

data "aws_ami" "latest_linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64"]
  }
}

### Create an EC2 instance

resource "aws_instance" "instance" {
  ami                         = data.aws_ami.latest_linux_ami.id
  instance_type               = var.instance_type
  availability_zone           = data.aws_availability_zones.available.names[0]
  associate_public_ip_address = true
  key_name                    = "vockey"
  vpc_security_group_ids      = [aws_security_group.sg_vpc.id]
  subnet_id                   = aws_subnet.publ_sub_1.id
  tags = {
    Name = "instance"
  }
  user_data = file("user_data.sh")

  provisioner "local-exec" {
    command = "echo Instance Type = ${self.instance_type}, Instance ID = ${self.id}, Public IP = ${self.public_ip}, AMI ID = ${self.ami} >> metadata"
  }
}