# creating aws networking for a project

resource "aws_vpc" "Prod_rock_VPC" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "rock_vpc"
  }
}


# creating public subnet

resource "aws_subnet" "Test-public-sub1" {
  vpc_id            = aws_vpc.Prod_rock_VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "rock_public_subnet"
  }
}


# creating public subnet 2

resource "aws_subnet" "test-public-sub2" {
  vpc_id            = aws_vpc.Prod_rock_VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "rock_public_subnet"
  }
}


# public route table

resource "aws_route_table" "Test-pub-route-table" {
  vpc_id = aws_vpc.Prod_rock_VPC.id


  route = []

  tags = {
    Name = "Rock-public-route-table"
  }
}


# associate Public subnet 1 with Public route table

resource "aws_route_table_association" "prod-pub-route-association1" {
  subnet_id      = aws_subnet.Test-public-sub1.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}


# associate Public subnet 2 with Public route table

resource "aws_route_table_association" "prod-pub-route-association2" {
  subnet_id      = aws_subnet.test-public-sub2.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}


#creating internet gateway

resource "aws_internet_gateway" "Test-igw" {
  vpc_id = aws_vpc.Prod_rock_VPC.id

  tags = {
    Name = "Rock_IGW"
  }
}

# associate internet gateway to public route table

resource "aws_route" "Test-igw-association" {
  route_table_id         = aws_route_table.Test-pub-route-table.id
  gateway_id             = aws_internet_gateway.Test-igw.id
  destination_cidr_block = "0.0.0.0/0"
}


