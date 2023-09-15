resource "aws_lambda_function" "lambda_translation" {
  filename      = data.archive_file.translation.output_path
  function_name = "lambda-translation"
  role          = aws_iam_role.iam_role_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

}

resource "aws_lambda_function_url" "lambda_translation_url" {
  function_name      = aws_lambda_function.lambda_translation.function_name
  authorization_type = "NONE"
}

resource "aws_lambda_permission" "url_translation" {
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.lambda_translation.function_name
  principal              = "*"
  function_url_auth_type = "NONE"
}
