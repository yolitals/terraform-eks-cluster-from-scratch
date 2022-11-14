# Obtener EKS Cluster
data "aws_eks_cluster" "eks-cluster" {
  name = var.cluster_name
}
# Obtener subnets
data "aws_subnet" "private-subnet" {
  cidr_block = var.private_subnet_cidr
}
data "aws_subnet" "private-subnet-2" {
  cidr_block = var.private_subnet_2_cidr
}
# Creacion de Fargate profiles
resource "aws_eks_fargate_profile" "kube-system" {
  cluster_name           = data.aws_eks_cluster.eks-cluster.name
  fargate_profile_name   = "kube-system"
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile-role.arn
  subnet_ids = [
    data.aws_subnet.private-subnet.id,
    data.aws_subnet.private-subnet-2.id
  ]

  selector {
    namespace = "kube-system"
  }
}

data "aws_eks_cluster_auth" "eks" {
  name = data.aws_eks_cluster.eks-cluster.id
}

resource "null_resource" "k8s_patcher-kube-system" {
  depends_on = [aws_eks_fargate_profile.kube-system]

  triggers = {
    endpoint = data.aws_eks_cluster.eks-cluster.endpoint
    ca_crt   = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority[0].data)
    token    = data.aws_eks_cluster_auth.eks.token
  }

  provisioner "local-exec" {
    command = <<EOH
cat >/tmp/ca.crt <<EOF
${base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority[0].data)}
EOF
kubectl \
  --server="${data.aws_eks_cluster.eks-cluster.endpoint}" \
  --certificate_authority=/tmp/ca.crt \
  --token="${data.aws_eks_cluster_auth.eks.token}" \
  patch deployment coredns \
  -n kube-system --type json \
  -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
EOH
  }

  lifecycle {
    ignore_changes = [triggers]
  }
}