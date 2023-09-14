data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "archive_file" "translation_methods" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/lambda_translation_methods.zip"
}

data "aws_iam_policy_document" "lambda_cloud_watch" {
  statement {
    effect    = "Allow"
    resources = ["arn:aws:logs:eu-central-1:${data.aws_caller_identity.current.account_id}:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    effect = "Allow"
    resources = [
      "arn:aws:logs:eu-central-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.lambda_translation_methods.function_name}:*"
    ]
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}