output "rag_service_url" {
  value = "http://${module.rag_service.rag_endpoint}:8680"
}

output "llm_service_url" {
  value = "http://${module.llm_service.llm_endpoint}:8000"
}