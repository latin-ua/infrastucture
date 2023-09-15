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
  source_dir  = abspath("${path.module}/code_translation_methods/")
  output_path = abspath("${path.module}/lambda_translation_methods.zip")
}

data "archive_file" "translation" {
  type        = "zip"
  source_dir  = abspath("${path.module}/code_translation/")
  output_path = abspath("${path.module}/lambda_translation.zip")
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
      "arn:aws:logs:eu-central-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.lambda_translation_methods.function_name}:*",
      "arn:aws:logs:eu-central-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.lambda_translation.function_name}:*"
    ]
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}