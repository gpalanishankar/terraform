resource "aws_vpc" "web-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    name = "web"
  }
}
resource "aws_subnet" "web-public-1-subnet" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = var.public-1-subnet
  availability_zone = "${var.region}a"
  tags = {
    name = "web-public-1-subnet"
  }
}
resource "aws_subnet" "web-public-2-subnet" {
  vpc_id                  = aws_vpc.web-vpc.id
  cidr_block              = var.public-2-subnet
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    name = "web-public-2-subnet"
  }
}

resource "aws_subnet" "web-private-1-subnet" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = var.private-1-subnet
  availability_zone = "${var.region}b"
  tags = {
    name = "web-private-1-subnet"
  }
}

resource "aws_subnet" "web-private-2-subnet" {
  vpc_id                  = aws_vpc.web-vpc.id
  cidr_block              = var.private-2-subnet
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true
  tags = {
    name = "web-private-2-subnet"
  }
}

resource "aws_route_table" "route-public-table" {
  vpc_id = aws_vpc.web-vpc.id
  tags = {
    name = "web-route-public-1"
  }
}

resource "aws_route_table" "route-private-table" {
  vpc_id = aws_vpc.web-vpc.id

  tags = {
    name = "web-route-public-2"
  }
}

resource "aws_route_table_association" "route-public-1-table" {
  subnet_id      = aws_subnet.web-public-1-subnet.id
  route_table_id = aws_route_table.route-public-table.id
}

resource "aws_route_table_association" "route-public-2-table" {
  subnet_id      = aws_subnet.web-public-2-subnet.id
  route_table_id = aws_route_table.route-public-table.id
}
resource "aws_route_table_association" "route-private-1-table" {
  subnet_id      = aws_subnet.web-private-1-subnet.id
  route_table_id = aws_route_table.route-private-table.id
}
resource "aws_route_table_association" "route-private-2-table" {
  subnet_id      = aws_subnet.web-private-2-subnet.id
  route_table_id = aws_route_table.route-private-table.id
}

resource "aws_internet_gateway" "web-igw" {
  vpc_id = aws_vpc.web-vpc.id
  #  tags = {
  #    Name = "${var.environment}-IGW"
  #  }
}
resource "aws_route" "public-internet-igw-route" {
  route_table_id         = aws_route_table.route-public-table.id
  gateway_id             = aws_internet_gateway.web-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
