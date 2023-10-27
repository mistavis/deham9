# Create a Virtual Private Cloud with CIDR 10.0.0.0/16 in the region us-west-2
resource "aws_vpc" "joanna_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "joanna_vpc"
  }
}

# Public Subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.joanna_vpc.id
  cidr_block              = "10.0.1.0/24" # 256 IPs
  availability_zone       = "us-west-2a"  # Replace with desired AZ
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1"
  }
}

# Private Subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.joanna_vpc.id
  cidr_block              = "10.0.2.0/24" # 256 IPs
  availability_zone       = "us-west-2a"  # Replace with desired AZ
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.joanna_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-west-2b" # Replace with desired AZ
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_2"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.joanna_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-west-2b" # Replace with desired AZ
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_2"
  }
}

# Internet Gateway - to have Internet traffic in public subnets
resource "aws_internet_gateway" "joanna_igw" {
  vpc_id = aws_vpc.joanna_vpc.id
  tags = {
    Name = "joanna_igw"
  }
}

# Routing tables
# Provides a resource to create a VPC routing table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.joanna_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.joanna_igw.id
  }
  tags = {
    Name = "public_route_table"
  }
}

# Provides a resource to create an association between a Public Route Table and a Public Subnet
resource "aws_route_table_association" "public_subnet_1_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1.id
  depends_on     = [aws_route_table.public_route_table, aws_subnet.public_subnet_1]
}

resource "aws_route_table_association" "public_subnet_2_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_2.id
  depends_on     = [aws_route_table.public_route_table, aws_subnet.public_subnet_2]

}