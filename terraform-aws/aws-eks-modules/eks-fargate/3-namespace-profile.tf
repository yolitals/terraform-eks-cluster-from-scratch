resource "aws_eks_fargate_profile" "staging" {
  cluster_name           = data.aws_eks_cluster.eks-cluster.name
  fargate_profile_name   = var.profile_namespace_name
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile-role.arn

  # These subnets must have the following resource tag: 
  # kubernetes.io/cluster/<CLUSTER_NAME>.
  subnet_ids = [
    data.aws_subnet.private-subnet.id,
    data.aws_subnet.private-subnet-2.id
  ]
  selector {
    namespace = var.profile_namespace_name
  }
}