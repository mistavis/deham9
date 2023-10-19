
### Create an EC2 instance

resource "aws_instance" "joanna_webserver" {
    ami                         = "ami-09100e341bda441c0" 
    instance_type               = "t3.micro"
    associate_public_ip_address = true
    key_name                    = "vockey"
    vpc_security_group_ids      = [aws_security_group.joanna_sg_http.id]
    subnet_id                   = aws_subnet.public_subnet_1.id
    tags = {
        Name = "joanna_webserver"
    }
}