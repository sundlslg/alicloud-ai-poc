variable "service_name" {
  description = "RAG 服务名称"
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
  description = "PostgreSQL 数据库配置"
  type = object({
    host       = string
    port       = number
    username   = string
    password   = string
    database   = string
    table_name string
  })
  sensitive = true
}

resource "alicloud_pai_service" "rag" {
  service_name = var.service_name
  service_type = "EAS"

  service_config = jsonencode({
    cloud = {
      computing = {
        instances = [{
          type = "ecs.c6.4xlarge"
        }]
      }
      networking = {
        vpc_id            = var.network_config.vpc_id
        vswitch_id        = var.network_config.vswitch_id
        security_group_id = var.network_config.security_group_id
      }
    }
    metadata = {
      cpu               = 16
      memory            = 32000
      instance          = 1
      enable_webservice = true
      name              = var.service_name
    }
    labels = {
      PAI_RAG_VERSION               = "0.1_custom"
      system_eas_deployment_type    = "rag"
      system_eas_rag_deployment_mode = "ragWithoutLLM"
    }
  })

  lifecycle {
    # 如果手动部署后某些字段可能会变化，防止 Terraform 每次计划更新，请忽略 service_config 字段变化
    ignore_changes = [service_config]
  }
}