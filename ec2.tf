
### Create an EC2 instance

resource "aws_instance" "server" {
  ami                         = "ami-09100e341bda441c0"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  key_name                    = "vockey"
  vpc_security_group_ids      = [aws_security_group.allow_web_traffic.id]
  subnet_id                   = aws_subnet.public-subnet-1.id
  tags = {
    Name = "server"
  }
  user_data = file("user_data.sh")

  provisioner "local-exec" {
    command = "echo Instance Type=${self.instance_type}, Instance ID=${self.id}, Public IP=${self.public_ip}, AMI ID=${self.ami} >> all_instance_details"
  }
}