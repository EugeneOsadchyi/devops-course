resource "aws_vpc" "node_app" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "NodeAppVpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.node_app.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "NodeApp Public"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.node_app.id
  cidr_block = "10.1.2.0/24"

  tags = {
    Name = "NodeApp Private"
  }
}

resource "aws_internet_gateway" "public_gw" {
  vpc_id = aws_vpc.node_app.id

  tags = {
    Name = "NodeApp"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.node_app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_gw.id
  }

  tags = {
    Name = "Public"
  }
}

resource "aws_route_table_association" "public_subnet_to_route_table" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat_ip_address" {
  vpc = true
}

resource "aws_nat_gateway" "private_nat_gateway" {
  allocation_id = aws_eip.nat_ip_address.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "Private NAT"
  }
}

resource "aws_route" "private_subnet_to_nat_gateway" {
  route_table_id = aws_vpc.node_app.main_route_table_id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.private_nat_gateway.id
}

resource "aws_route_table_association" "private_subnet_to_main_route_table" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_vpc.node_app.main_route_table_id
}
