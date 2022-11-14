resource "aws_vpc" "eks-vpc" {
  cidr_block = var.vpc_cidr

  # Must be enabled for EFS
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "eks-vpc"
  }
}
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Name = "internet-gateway"
  }
}

# Create nat gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "nat"
  }
}