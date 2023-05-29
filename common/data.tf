data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "tf_pipeline_role_assume_policy" {
  statement {

    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.tf_pipeline_user.arn]
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