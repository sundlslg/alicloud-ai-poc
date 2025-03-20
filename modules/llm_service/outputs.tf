output "llm_endpoint" {
  description = "LLM服务访问端点"
  value       = alicloud_pai_service.llm.service_endpoint
}

output "model_storage_bucket" {
  description = "模型存储OSS Bucket名称"
  value       = alicloud_oss_bucket.model_storage.bucket
}

output "api_endpoint" {
  description = "OpenAI兼容API端点"
  value       = "${alicloud_pai_service.llm.service_endpoint}:8000"
}