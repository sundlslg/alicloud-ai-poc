terraform {
  required_version = ">= 1.0"
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.200"
    }
  }
}

provider "alicloud" {
  region     = var.region
  access_key = var.ali_access_key
  secret_key = var.ali_secret_key
}

module "network" {
  source = "./modules/network"
}

module "llm_service" {
  source = "./modules/llm_service"

  llm_config = {
    instance_type  = "ecs.gn7i-c16g1.4xlarge"
    model_name     = "DeepSeek-R1-Distill-Qwen-7B"
    gpu_count      = 1
    memory_size    = 60000
    network_config = {
      vpc_id            = module.network.network_config.vpc_id
      vswitch_id        = module.network.network_config.vswitch_id
      security_group_id = module.network.network_config.security_group_id
      region            = module.network.network_config.region
    }
  }
}

module "rag_service" {
  source = "./modules/rag_service"

  network_config  = module.network.network_config
  service_name    = "ragpgtest"
  postgres_config = {
    host       = "pgm-uf6t7idr2x305eq7.pg.rds.aliyuncs.com"
    port       = 5432
    username   = "rdsadm"
    password   = "!QAZ2wsx"  # 生产环境建议使用 Vault 管理敏感信息
    database   = "RAG_PGDB"
    table_name = "ragpgtable"
  }
  # 确保在 rag_service 中引用 llm_service 的 endpoint 时，llm_service 已经创建
  depends_on = [module.llm_service]
}