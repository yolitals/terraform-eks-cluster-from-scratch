variable "cluster_name" {
  default = "eks-cloud-course"
  description = "EKS Cluster name"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "Cidr block to create a VPC"
}
variable "public_subnet_cidr" {
  default = "10.0.64.0/19"
  description = "CIDR block of public subnet, it must be in VPC cidr range (A subnet will be created with this CIDR)."
}
variable "public_subnet_2_cidr" {
  default = "10.0.96.0/19"
  description = "CIDR block of public subnet, it must be in VPC cidr range (A subnet will be created with this CIDR)."
}
variable "public_subnet_zone" {
  default = "us-east-1a"
  description = "Availability zone to public subnet."
}
variable "public_subnet_2_zone" {
  default = "us-east-1b"
  description = "Availability zone to public subnet."
}
variable "private_subnet_cidr" {
  default = "10.0.0.0/19"
  description = "CIDR block of private subnet, it must be in VPC cidr range (A subnet will be created with this CIDR)."
}
variable "private_subnet_2_cidr" {
  default = "10.0.32.0/19"
  description = "CIDR block of private subnet, it must be in VPC cidr range (A subnet will be created with this CIDR)."
}
variable "private_subnet_zone" {
  default = "us-east-1b"
  description = "Availability zone to private subnet."
}
variable "private_subnet_2_zone" {
  default = "us-east-1a"
  description = "Availability zone to private subnet."
}
variable "eks_role_name" {
  default = "eks-cluster-role"
  description = "Name of role for EKS."
}
variable "eks_fargate_role_name" {
  default = "eks-fargate-cloud-course"
  description = "Name of role to Fargate."
}