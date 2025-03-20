output "llm_endpoint" {
  description = "LLM 服务访问端点"
  value       = alicloud_pai_service.llm.service_endpoint
}

output "model_storage_bucket" {
  description = "模型存储 OSS Bucket 名称"
  value       = alicloud_oss_bucket.model_storage.bucket
}

output "api_endpoint" {
  description = "OpenAI 兼容 API 端点"
  value       = "${alicloud_pai_service.llm.service_endpoint}:8000"
}
