locals {
  frontend_bucket_name = "frontend-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket" "frontend" {
  bucket = local.frontend_bucket_name

  tags = {
    Name = local.frontend_bucket_name
  }
}

resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend.id
  policy = data.aws_iam_policy_document.cloudfront_s3_bucket_policy.json
}

output "frontend_bucket_url" {
  value = aws_s3_bucket.frontend.bucket_domain_name
}
