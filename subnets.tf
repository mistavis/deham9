# Create Public Subnet 1
resource "aws_subnet" "publ_sub_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.publ_cidr_1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }

  provisioner "local-exec" {
    command = "echo public subnet 1 = ${self.id} >> metadata"
  }
}

# Create Private Subnet 1
resource "aws_subnet" "priv_sub_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.priv_cidr_1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
  provisioner "local-exec" {
    command = "echo private subnet 1 = ${self.id} >> metadata"
  }
}

# Create Public Subnet 2
resource "aws_subnet" "publ_sub_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.publ_cidr_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }

  provisioner "local-exec" {
    command = "echo public subnet 2=${self.id} >> metadata"
  }
}

# Create Private Subnet 2
resource "aws_subnet" "priv_sub_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.priv_cidr_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-2"
  }
  provisioner "local-exec" {
    command = "echo private subnet 2 = ${self.id} >> metadata"
  }

}

# Create a subnet group for the database
resource "aws_db_subnet_group" "db_subnet" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.priv_sub_1.id, aws_subnet.priv_sub_2.id]

  tags = {
    Name = "db-subnet-group"
  }
}