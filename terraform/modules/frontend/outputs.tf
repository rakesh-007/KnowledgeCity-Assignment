output "frontend_bucket_name" {
  value = aws_s3_bucket.frontend_bucket.bucket
}

output "cloudfront_distribution_domain" {
  value = aws_cloudfront_distribution.frontend_distribution.domain_name
}
