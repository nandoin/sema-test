resource "aws_vpc" "elasticsearch" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "elasticsearch-vpc"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.elasticsearch.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "${var.region_aws}a"
  tags = {
    Name = "elasticsearch-private-subnet"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.elasticsearch.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.elasticsearch.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_internet_gateway" "elasticsearch" {
  vpc_id = aws_vpc.elasticsearch.id
  tags = {
    Name = "elasticsearch-igw"
  }
}
