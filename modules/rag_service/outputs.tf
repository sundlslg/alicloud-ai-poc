output "service_endpoint" {
  description = "RAG服务访问端点"
  value       = alicloud_pai_service.rag.service_endpoint
}

output "nginx_port" {
  description = "Nginx容器暴露端口"
  value       = 8680
}

output "api_port" {
  description = "主服务API端口"
  value       = 8001
}