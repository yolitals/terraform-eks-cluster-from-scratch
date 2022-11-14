# Creación del EKS Cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks-role.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    subnet_ids = [
      aws_subnet.private-subnet.id,
      aws_subnet.private-subnet-2.id,
      aws_subnet.public-subnet.id,
      aws_subnet.public-subnet-2.id
    ]
  }

  # Asegurar que los permisos del IAM Role estan creados 
  depends_on = [
    aws_iam_role_policy_attachment.eks-policy-attachment,
  ]
}