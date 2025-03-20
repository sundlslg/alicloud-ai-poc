output "rag_endpoint" {
  description = "RAG 服务访问端点"
  value       = alicloud_pai_service.rag.service_endpoint
}

output "nginx_port" {
  description = "Nginx 容器暴露端口"
  value       = 8680
}

output "api_port" {
  description = "主服务 API 端口"
  value       = 8001
}
