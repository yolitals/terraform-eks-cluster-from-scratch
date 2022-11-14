variable "cluster_name" {
  default = "eks-cloud-course"
  description = "EKS Cluster name"
}
variable "existing_vpc_cidr" {
  default = "10.0.0.0/16"
  description = "Cidr block of existing VPC to get VPC id(This is not to create VPC)."
}