data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "cloudfront_s3_bucket_policy" {
  statement {

    actions = [
      "s3:GetObject",
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        "arn:aws:cloudfront::991225504892:distribution/E105UU8V5LGPMZ"
      ]
    }
    resources = ["${aws_s3_bucket.frontend.arn}/*"]
  }
}
