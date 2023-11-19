
# Create a Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.cidr_blocks
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "route-table"
  }
}

# Create an association between the Route Table and the Public Subnets
resource "aws_route_table_association" "rta_1" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.publ_sub_1.id
  depends_on     = [aws_route_table.route_table, aws_subnet.publ_sub_1]
}

resource "aws_route_table_association" "rta_2" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.publ_sub_2.id
  depends_on     = [aws_route_table.route_table, aws_subnet.publ_sub_2]

}