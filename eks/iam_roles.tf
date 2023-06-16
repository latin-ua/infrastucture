locals {
  cluster_role_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
  ]
  node_group_policies = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonVPCReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    "arn:aws:iam::aws:policy/AWSWAFReadOnlyAccess",
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

resource "aws_iam_policy_attachment" "eks_node_group_role_policy_attachment" {
  for_each   = toset(local.node_group_policies)
  name       = "eks-node-group-role-policy-attachment"
  roles      = [aws_iam_role.eks_node_group_role.name]
  policy_arn = each.key
}

resource "aws_iam_policy_attachment" "alb_ingress_controller_policy_attachment" {
  name       = "alb-ingress-controller-policy-attachment"
  roles      = [aws_iam_role.eks_node_group_role.name]
  policy_arn = aws_iam_policy.alb_ingress_controller_iam_policy.arn
}

resource "aws_iam_policy_attachment" "aws_ingress_controller_policy_attachment" {
  name       = "aws-ingress-controller-policy-attachment"
  roles      = [aws_iam_role.eks_node_group_role.name]
  policy_arn = aws_iam_policy.alb_ingress_controller_iam_policy.arn
}
