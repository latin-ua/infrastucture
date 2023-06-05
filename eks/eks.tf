resource "aws_eks_cluster" "main_cluster" {
  name     = "main-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.27"

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids = [
      "subnet-010dc048b3eecbb82",
      "subnet-09e4c645f6869927f",
      "subnet-06a91b396647deba9",
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_policy_attachment,
  ]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.main_cluster.name
  addon_name   = "vpc-cni"
}
resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.main_cluster.name
  addon_name   = "coredns"
}
resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.main_cluster.name
  addon_name   = "kube-proxy"
}