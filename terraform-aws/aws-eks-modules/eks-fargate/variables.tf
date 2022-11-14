variable "cluster_name" {
  default = "eks-cloud-course"
  description = "EKS Cluster name"
}
variable "existing_vpc_cidr" {
  default = "10.0.0.0/16"
  description = "Cidr block of existing VPC to get VPC id(This is not to create VPC)."
}
variable "private_subnet_cidr" {
  default = "10.0.0.0/19"
  description = "CIDR block of existing private subnet."
}
variable "private_subnet_2_cidr" {
  default = "10.0.32.0/19"
  description = "CIDR block of existing private subnet."
}
variable "eks_role_name" {
  default = "eks-cluster-role"
  description = "Name of role for EKS."
}
variable "eks_fargate_role_name" {
  default = "eks-fargate-cloud-course"
  description = "Name of role to Fargate."
}
variable "profile_namespace_name" {
  default = "development"
  description = "The name for Fargate profile for namespace."
}