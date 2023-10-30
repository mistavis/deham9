# Create a Virtual Private Cloud with CIDR 10.0.0.0/16 in the region us-west-2
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc"
  }
}

# Create Public Subnet 1 in the AZ us-west-2a
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24" # 256 IPs
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

# Create Private Subnet 1 in the AZ us-west-2a
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24" # 256 IPs
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}

# Create Public Subnet 2 in the AZ us-west-2b
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

# Create Private Subnet 2 in the AZ us-west-2b
resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-2"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"
  }
}

# Create a Route Table
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "route-table"
  }
}

# Create an association between the Route Table and the Public Subnets
resource "aws_route_table_association" "rta-1" {
  route_table_id = aws_route_table.route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
  depends_on     = [aws_route_table.route-table, aws_subnet.public-subnet-1]
}

resource "aws_route_table_association" "rta-2" {
  route_table_id = aws_route_table.route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
  depends_on     = [aws_route_table.route-table, aws_subnet.public-subnet-2]

}