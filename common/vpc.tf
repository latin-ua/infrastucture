locals {
  subnet_tags = {
    "kubernetes.io/cluster/main-cluster" = "",
    "kubernetes.io/role/elb"             = "1",
  }
}

resource "aws_vpc" "default_vpc" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_subnet" "subnet_eu_central_1a" {
  vpc_id                  = aws_vpc.default_vpc.id
  cidr_block              = "172.31.16.0/20"
  map_public_ip_on_launch = true

  tags = local.subnet_tags
}

resource "aws_subnet" "subnet_eu_central_1b" {
  vpc_id                  = aws_vpc.default_vpc.id
  cidr_block              = "172.31.32.0/20"
  map_public_ip_on_launch = true

  tags = local.subnet_tags
}

resource "aws_subnet" "subnet_eu_central_1c" {
  vpc_id                  = aws_vpc.default_vpc.id
  cidr_block              = "172.31.0.0/20"
  map_public_ip_on_launch = true

  tags = local.subnet_tags
}
