provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "simple-vpc"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Simple IGW"
  }
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.internet-gateway]
  tags = {
    Name = "Simple EIP"
  }
}

# NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.bootcamp-public-subnet[0].id

  tags = {
    Name        = "Simple NAT"
  }
}


resource "aws_subnet" "bootcamp-public-subnet" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.public-subnet-cidr)
  cidr_block = element(var.public-subnet-cidr, count.index)
  availability_zone = element(var.public-availability-zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Simple Public Subnet ${count.index}"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Simple Public Route Table"
  }
}


resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Simple Private Route Table"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet-gateway.id
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "public-subnet-route-table-association" {
  count = length(aws_subnet.bootcamp-public-subnet)
  subnet_id = element(aws_subnet.bootcamp-public-subnet.*.id, count.index)
  route_table_id = aws_route_table.public-route-table.id
}


resource "aws_subnet" "bootcamp-private-subnet" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.private-subnets-cidr)
  cidr_block = element(var.private-subnets-cidr, count.index)
  availability_zone = element(var.private-availability-zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "Simple Private Subnet ${count.index}"
  }
}

resource "aws_route_table_association" "private-subnet-route-table-association" {
  count = length(var.private-subnets-cidr)
  subnet_id      = element(aws_subnet.bootcamp-private-subnet.*.id, count.index)
  route_table_id = aws_route_table.private-route-table.id
}
