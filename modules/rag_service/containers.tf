locals {
  rag_containers = [
    # Nginx容器
    {
      name   = "nginx-container"
      image  = "eas-registry-vpc.cn-shanghai.cr.aliyuncs.com/pai-eas/pai-rag:0.2.0-nginx"
      port   = 8680
      script = "/docker-entrypoint.sh nginx"
      env    = []
    },
    # UI容器
    {
      name   = "ui-container"
      image  = "eas-registry-vpc.cn-shanghai.cr.aliyuncs.com/pai-eas/pai-rag:0.2.0-ui"
      port   = 8002
      script = "pai_rag ui"
      env = [
        {
          name  = "PAIRAG_RAG__SETTING__interactive"
          value = "false"
        }
      ]
    },
    # 主服务容器
    {
      name   = "main-container"
      image  = "eas-registry-vpc.cn-shanghai.cr.aliyuncs.com/pai-eas/pai-rag:0.2.0"
      port   = 8001
      script = "pai_rag serve"
      env = [
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__type", value = "PostgreSQL" },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__host", value = var.postgres_config.host },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__port", value = tostring(var.postgres_config.port) },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__username", value = var.postgres_config.username },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__password", value = var.postgres_config.password },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__database", value = var.postgres_config.database },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__table_name", value = var.postgres_config.table_name },
        { name = "PAIRAG_RAG__DATA_READER__enable_image_ocr", value = "false" },
        { name = "PAIRAG_RAG__LLM__source", value = "PaiEas" },
        { name = "PAIRAG_RAG__LLM__endpoint", value = "http://${module.llm_service.llm_endpoint}:8007" },
        { name = "PAIRAG_RAG__LLM__token", value = "abc" },
        { name = "PAIRAG_RAG__EMBEDDING__source", value = "HuggingFace" },
        { name = "PAIRAG_RAG__EMBEDDING__model_name", value = "bge-small-zh-v1.5" }
      ]
    }
  ]
}