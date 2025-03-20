# modules/rag_service/variables.tf
variable "service_name" {
  description = "RAG服务名称"
  type        = string
  default     = "ragpgtest"
}

variable "network_config" {
  description = "网络配置参数"
  type = object({
    vpc_id            = string
    vswitch_id        = string
    security_group_id = string
    region            = string
  })
}

variable "postgres_config" {
  description = "PostgreSQL数据库配置"
  type = object({
    host      = string
    port      = number
    username  = string
    password  = string
    database  = string
    table_name = string
  })
  sensitive = true
}

# modules/rag_service/containers.tf
locals {
  rag_containers = [
    {
      name   = "nginx"
      image  = "eas-registry-vpc.cn-shanghai.cr.aliyuncs.com/pai-eas/pai-rag:0.2.0-nginx"
      port   = 8680
      script = "/docker-entrypoint.sh nginx"
    },
    {
      name   = "ui"
      image  = "eas-registry-vpc.cn-shanghai.cr.aliyuncs.com/pai-eas/pai-rag:0.2.0-ui"
      port   = 8002
      script = "pai_rag ui"
      env = [
        { name = "PAIRAG_RAG__SETTING__interactive", value = "false" }
      ]
    },
    {
      name   = "main"
      image  = "eas-registry-vpc.cn-shanghai.cr.aliyuncs.com/pai-eas/pai-rag:0.2.0"
      port   = 8001
      script = "pai_rag serve"
      env = [
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__type",      value = "PostgreSQL" },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__host",     value = var.postgres_config.host },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__port",     value = tostring(var.postgres_config.port) },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__username", value = var.postgres_config.username },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__password", value = var.postgres_config.password },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__database", value = var.postgres_config.database },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__table_name", value = var.postgres_config.table_name },
        { name = "PAIRAG_RAG__LLM__endpoint",                 value = "http://${module.llm_service.llm_endpoint}:8007" }
      ]
    }
  ]
}

# modules/rag_service/outputs.tf
output "rag_endpoint" {
  value = alicloud_pai_service.rag.service_endpoint
}