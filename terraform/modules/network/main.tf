data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "devops_course" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "DevOps Course VPC"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.devops_course.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "Public"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.devops_course.id
  cidr_block        = "10.1.2.0/25"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Private"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.devops_course.id
  cidr_block        = "10.1.2.128/25"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.devops_course.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_gw.id
  }

  tags = {
    Name = "Public"
  }
}

resource "aws_internet_gateway" "public_gw" {
  vpc_id = aws_vpc.devops_course.id

  tags = {
    Name = "DevOps Course GW"
  }
}


resource "aws_route_table_association" "public_subnet_to_route_table" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.devops_course.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private_nat_gateway.id
  }

  tags = {
    Name = "Private"
  }
}

resource "aws_route_table_association" "private_1_subnet_to_private_route_table" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2_subnet_to_private_route_table" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
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
