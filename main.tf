terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# Provider profile and region in which all the resources will create
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

# Resource to create s3 bucket
resource "aws_s3_bucket" "joannas-challenge-bucket"{
  bucket = "joannas-challenge-bucket"

  tags = {
    Name = "S3Bucket"
  }
}
resource "aws_instance" "joannas-test-ec2" {
  ami = "ami-09100e341bda441c0" 
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = {
    Name = "joannas-test-ec2"
  }
}
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MyVPC"
  }
}

  resource "aws_subnet" "public_subnet_1" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-west-2a"  # Replace with desired AZ
    map_public_ip_on_launch = true
  
    tags = {
      Name = "PublicSubnet1"
    }
  }
  
  resource "aws_subnet" "public_subnet_2" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "us-west-2b"  # Replace with desired AZ
    map_public_ip_on_launch = true
  
    tags = {
      Name = "PublicSubnet2"
    }
  }
  
  resource "aws_subnet" "private_subnet_1" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-west-2a"  # Replace with desired AZ
  
    tags = {
      Name = "PrivateSubnet1"
    }
  }
  
  resource "aws_subnet" "private_subnet_2" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-west-2b"  # Replace with desired AZ
  
    tags = {
      Name = "PrivateSubnet2"
    }
  }
  
  resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
  
    tags = {
      Name = "MyInternetGateway"
    }
  }
  
  resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.my_vpc.id
  
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.my_igw.id
    }
  
    tags = {
      Name = "PublicRouteTable"
    }
  }
  
  resource "aws_route_table_association" "public_subnet_1_association" {
    subnet_id      = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id
  }
  
  resource "aws_route_table_association" "public_subnet_2_association" {
    subnet_id      = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_route_table.id
  }
