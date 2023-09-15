resource "aws_iam_role" "iam_role_for_lambda" {
  name               = "iam-role-for-lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_policy" "lambda_cloud_watch" {
  name   = "lambda-cloud-watch"
  policy = data.aws_iam_policy_document.lambda_cloud_watch.json
}

resource "aws_iam_policy_attachment" "lambda_cloud_watch_policy_attachment" {
  name       = "lambda-cloud-watch-attachment"
  roles      = [aws_iam_role.iam_role_for_lambda.name]
  policy_arn = aws_iam_policy.lambda_cloud_watch.arn
}
