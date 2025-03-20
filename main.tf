module "network" {
  source = "./modules/network"
}

module "rag_service" {
  source = "./modules/rag_service"

  network_config = module.network.network_config
  service_name   = "ragpgtest"
  postgres_config = {
    host      = "pgm-uf6t7idr2x305eq7.pg.rds.aliyuncs.com"
    port      = 5432
    username  = "rdsadm"
    password  = "!QAZ2wsx"  # 生产环境应使用Vault管理
    database  = "RAG_PGDB"
    table_name = "ragpgtable"
  }
}

module "llm_service" {
  source = "./modules/llm_service"

  llm_config = {
    instance_type = "ecs.gn7i-c16g1.4xlarge"
    model_name    = "DeepSeek-R1-Distill-Qwen-7B"
    gpu_count     = 1
    memory_size   = 60000
    network_config = module.network.network_config
  }
}