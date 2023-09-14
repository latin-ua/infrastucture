resource "aws_iam_role" "iam_role_for_lambda" {
  name               = "iam-role-for-lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}