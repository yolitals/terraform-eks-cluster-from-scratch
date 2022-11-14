#-----------------------------Nota-------------------------------#
# Estos modulos se deben utilizar por separado,
# Revise las instrucciones en el Readme para mayor información.
##################################################################
module "eks-cluster" {
  source = "./aws-eks-modules/eks-cluster"
  cluster_name = "eks-cluster-cloud"
}
module "eks-fargate" {
  source = "./aws-eks-modules/eks-fargate"
  cluster_name = "eks-cluster-cloud"
}
module "loadbalancer-controller" {
  source = "./aws-eks-modules/loadbalancer-controller"
  cluster_name = "eks-cluster-cloud"
}