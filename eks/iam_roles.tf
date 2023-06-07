locals {
  cluster_role_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
  ]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = data.aws_iam_policy_document.eks_cluster_role_assume_policy.json
}

resource "aws_iam_policy_attachment" "eks_cluster_role_policy_attachment" {
  for_each   = toset(local.cluster_role_policies)
  name       = "eks-cluster-role-policy-attachment"
  roles      = [aws_iam_role.eks_cluster_role.name]
  policy_arn = each.key
}

resource "aws_iam_role" "eks_node_group_role" {
  name = "eks-node-group-role"

  assume_role_policy = data.aws_iam_policy_document.eks_node_group_role_assume_policy.json
}