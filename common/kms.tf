resource "aws_kms_key" "k8s_secrets" {}

resource "aws_kms_alias" "k8s_secrets" {
  name          = "alias/k8s-secrets-alias"
  target_key_id = aws_kms_key.k8s_secrets.key_id
}
