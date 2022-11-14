# Public subnets
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.eks-vpc.id

  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.public_subnet_zone
  map_public_ip_on_launch = true
  tags = {
    "kubernetes.io/role/elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.eks-vpc.id

  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.public_subnet_2_zone
  map_public_ip_on_launch = true
  tags = {
    "kubernetes.io/role/elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}
# Private subnets
resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.private_subnet_zone
  tags = {
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}
resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.private_subnet_2_cidr
  availability_zone       = var.private_subnet_2_zone
  tags = {
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}