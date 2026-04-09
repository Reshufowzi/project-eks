resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = ["subnet-xxxx", "subnet-yyyy"]
  }
}

resource "aws_iam_role" "eks_role" {
  name = "${var.cluster_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "nodes"
  node_role_arn   = aws_iam_role.eks_role.arn

  subnet_ids = ["subnet-xxxx", "subnet-yyyy"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = [var.node_instance_type]
}
