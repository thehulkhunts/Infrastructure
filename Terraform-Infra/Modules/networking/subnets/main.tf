resource "aws_subnet" "public_subnet" {
  vpc_id = var.vpc_id
  count = length(var.public_subnets_cidrs)
  map_public_ip_on_launch = true
  cidr_block = element(var.public_subnets_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment}-public-subnets"
    Environment = var.environment
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = var.vpc_id
  count = length(var.private_subnets_cidrs)
  map_public_ip_on_launch = false
  cidr_block = element(var.private_subnets_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment}-private-subnets"
    Environment = var.environment
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "${var.environment}-internet-gateway"
    Environment = var.environment
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "${var.environment}-public-route-table"
    Environment = var.environment
  }
} 

resource "aws_route_table_association" "public_route_table_association" {
  count = length(var.public_subnets_cidrs)
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "nat_eip" {
  count = length(aws_subnet.private_subnet.*.id)
  tags = {
    Name = "${var.environment}-nat-eip-${count.index + 1}"
    Environment = var.environment
  }
}
resource "aws_nat_gateway" "nat_gateway" {
  count = length(aws_subnet.private_subnet.*.id)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  depends_on = [aws_internet_gateway.internet_gateway]

  tags = {
    Name = "${var.environment}-nat-gateway-${count.index + 1}"
    Environment = var.environment
  }
}
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  count = length(aws_subnet.private_subnet.*.id)
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gateway.*.id, count.index)
  }
  tags = {
    Name = "${var.environment}-private-route-table"
    Environment = var.environment
  }
}
resource "aws_route_table_association" "private_route_table_association" {
  count = length(aws_subnet.private_subnet.*.id)
  subnet_id = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}