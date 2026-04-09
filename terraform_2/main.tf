provider "aws" {
  region = var.region
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = var.cluster_name
}

# Store cluster name in SSM
resource "aws_ssm_parameter" "cluster_name" {
  name  = "/eks/staging/cluster_name"
  type  = "String"
  value = var.cluster_name
}
