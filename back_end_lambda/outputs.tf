output "get_translation_methods_url" {
  value = aws_lambda_function_url.lambda_translation_methods_url.function_url
}

output "translation_url" {
  value = aws_lambda_function_url.lambda_translation_url.function_url
}