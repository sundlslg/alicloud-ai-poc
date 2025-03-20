output "rag_service_url" {
  description = "RAG 服务访问 URL"
  value       = "http://${module.rag_service.rag_endpoint}:8680"
}

output "llm_service_url" {
  description = "LLM 服务访问 URL (OpenAI 兼容)"
  value       = module.llm_service.api_endpoint
}