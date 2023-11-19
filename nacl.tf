# Create Network Access Control List

resource "aws_network_acl" "nacl" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_network_acl_rule" "inbound" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  protocol       = -1
  rule_action    = "allow"
  egress         = false
  cidr_block     = aws_subnet.publ_sub_1.cidr_block
}
resource "aws_network_acl_rule" "outbound" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  protocol       = -1
  rule_action    = "allow"
  egress         = true
  cidr_block     = aws_subnet.publ_sub_2.cidr_block
}