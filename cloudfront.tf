module "cloudfront_with_oai" {
  source              = "terraform-aws-modules/cloudfront/aws"
  comment             = "Cloudfront distribution with private S3 origin"
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    private_s3_origin = "cloudfront_identity"
  }

  origin = {
    private_s3_origin = {
      domain_name = module.origin_bucket.s3_bucket_bucket_regional_domain_name
      s3_origin_config = {
        origin_access_identity = "private_s3_origin"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "private_s3_origin" # key in `origin` above
    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 5400
    min_ttl     = 3600
    max_ttl     = 7200

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = false
      }

  default_root_object = "index.html"
  custom_error_response = {
    error404 = {
      error_code         = 404
      response_code      = 404
      response_page_path = "/index.html"
    }
  }
}

