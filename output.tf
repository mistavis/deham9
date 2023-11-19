# Create an output file for relevant resources

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_1" {
  value = aws_subnet.publ_sub_1.id
}

output "public_subnet_2" {
  value = aws_subnet.publ_sub_2.id
}

output "private_subnet_1" {
  value = aws_subnet.priv_sub_1.id
}

output "private_subnet_2" {
  value = aws_subnet.priv_sub_2.id
}

output "security_group_vpc" {
  value = aws_security_group.sg_vpc.id
}

output "aws_ami_linux" {
  value = data.aws_ami.latest_linux_ami.id
}

output "instance_id" {
  value = aws_instance.instance.id
}

output "db_instance_endpoint" {
  value = aws_db_instance.instance_db.endpoint
}