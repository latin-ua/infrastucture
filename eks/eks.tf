locals {
  subnet_ids = [
    "subnet-010dc048b3eecbb82",
    "subnet-09e4c645f6869927f",
    "subnet-06a91b396647deba9",
  ]
}

resource "aws_eks_cluster" "main_cluster" {
  name     = "main-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.27"

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = local.subnet_ids
  }

  depends_on = [
    aws_iam_policy_attachment.eks_cluster_role_policy_attachment["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"],
    aws_iam_policy_attachment.eks_cluster_role_policy_attachment["arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"],
  ]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.main_cluster.name
  addon_name   = "vpc-cni"
}
resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.main_cluster.name
  addon_name   = "coredns"
  depends_on = [
    aws_eks_node_group.main_node_group
  ]
}
resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.main_cluster.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_node_group" "main_node_group" {
  cluster_name    = aws_eks_cluster.main_cluster.name
  node_group_name = "main-node-group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = local.subnet_ids
  instance_types = [
    "t2.micro"
  ]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_policy_attachment.eks_node_group_role_policy_attachment["arn:aws:iam::aws:policy/AWSWAFReadOnlyAccess"],
    aws_iam_policy_attachment.eks_node_group_role_policy_attachment["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"],
    aws_iam_policy_attachment.eks_node_group_role_policy_attachment["arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"],
    aws_iam_policy_attachment.eks_node_group_role_policy_attachment["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"],
    aws_iam_policy_attachment.eks_node_group_role_policy_attachment["arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"],
    aws_iam_policy_attachment.eks_node_group_role_policy_attachment["arn:aws:iam::aws:policy/AWSWAFReadOnlyAccess"],

  ]
}