output "cloudfront_distribution_domain_name" {
  value = module.cloudfront_with_oai.cloudfront_distribution_domain_name
}

output "s3_bucket_bucket_domain_name" {
  value = module.origin_bucket.s3_bucket_bucket_domain_name
}