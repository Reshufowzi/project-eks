provider "aws" {
  region = var.region
}

module "eks" {
  source = "./modules/eks"

  cluster_name        = var.cluster_name
  node_instance_type  = var.node_instance_type
}

# Store cluster name in SSM
resource "aws_ssm_parameter" "eks_cluster_name" {
  name  = "/eks/cluster_name"
  type  = "String"
  value = module.eks.cluster_name
}
