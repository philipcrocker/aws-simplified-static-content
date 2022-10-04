module "origin_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  bucket        = "private-s3-orgin-bucket"
  # bucket        = "${var.bucket_name}"
  # acl           = "private"
  force_destroy = true
}

data "aws_iam_policy_document" "oai_policy" {
  version = "2012-10-17"
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.origin_bucket.s3_bucket_arn}/*"]
    principals {
      type        = "AWS"
      identifiers = module.cloudfront_with_oai.cloudfront_origin_access_identity_iam_arns
    }
  }
}

resource "aws_s3_bucket_acl" "origin_bucket_acl" {
  bucket = module.origin_bucket.s3_bucket_id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "origin_bucket_site_config" {
  bucket = module.origin_bucket.s3_bucket_id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "origin_bucket_policy" {
  bucket = module.origin_bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.oai_policy.json
}
resource "aws_s3_bucket_public_access_block" "origin_bucket_access_control" {
  bucket = module.origin_bucket.s3_bucket_id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}