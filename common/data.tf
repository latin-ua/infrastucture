data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "tf_pipeline_role_assume_policy" {
  statement {

    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
data "aws_iam_policy_document" "tf_pipeline_role_policy" {
  statement {

    actions = [
      "*",
    ]
    resources = ["*"]
  }
}