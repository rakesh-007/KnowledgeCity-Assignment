output "frontend_url" {
  value = module.frontend.cloudfront_distribution_domain
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "media_server_public_ip" {
  value = module.media_server.media_server_public_ip
}

output "microservice_public_ip" {
  value = module.microservice.clickhouse_public_ip
}
