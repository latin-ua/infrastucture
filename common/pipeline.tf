resource "aws_iam_role" "tf_pipeline_role" {
  name = "tf-pipeline-role"

  assume_role_policy = data.aws_iam_policy_document.tf_pipeline_role_assume_policy.json
}

resource "aws_iam_policy" "tf_pipeline_role_policy" {
  name        = "tf-pipeline-role-policy"
  description = "Policy for terraform pipeline role"

  policy = data.aws_iam_policy_document.tf_pipeline_role_policy.json
}

resource "aws_iam_policy_attachment" "tf_pipeline_role_policy_attachment" {
  name       = "tf-pipeline-role-policy"
  roles      = [aws_iam_role.tf_pipeline_role.name]
  policy_arn = aws_iam_policy.tf_pipeline_role_policy.arn
}

resource "aws_iam_user" "tf_pipeline_user" {
  name = "tf-pipeline-user"
}

resource "aws_iam_access_key" "tf_pipeline_user_key" {
  user = aws_iam_user.tf_pipeline_user.name
}

output "key_id" {
  value = aws_iam_access_key.tf_pipeline_user_key.id
}

output "secret" {
  sensitive = true
  value     = aws_iam_access_key.tf_pipeline_user_key.secret
}