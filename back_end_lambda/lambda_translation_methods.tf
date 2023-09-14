resource "aws_lambda_function" "lambda_translation_methods" {
  filename      = data.archive_file.translation_methods.output_path
  function_name = "lambda-translation-methods"
  role          = aws_iam_role.iam_role_for_lambda.arn
  handler       = "translation_methods.lambda_handler"
  runtime       = "python3.11"

}

resource "aws_lambda_function_url" "lambda_translation_methods_url" {
  function_name      = aws_lambda_function.lambda_translation_methods.function_name
  authorization_type = "NONE"
}

resource "aws_lambda_permission" "url_translation_methods" {
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.lambda_translation_methods.function_name
  principal              = "*"
  function_url_auth_type = "NONE"
}