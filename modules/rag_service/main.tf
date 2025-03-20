variable "service_name" {
  default = "ragpgtest"
}

variable "network_config" {
  type = object({
    vpc_id            = string
    vswitch_id        = string
    security_group_id = string
    region            = string
  })
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
      cpu              = 16
      memory           = 32000
      instance         = 1
      enable_webservice = true
      name             = var.service_name
    }
    labels = {
      PAI_RAG_VERSION               = "0.1_custom"
      system_eas_deployment_type    = "rag"
      system_eas_rag_deployment_mode = "ragWithoutLLM"
    }
  })
}

# 容器配置单独文件 (modules/rag_service/containers.tf)
locals {
  rag_containers = [
    # Nginx容器
    {
      image  = "eas-registry-vpc.cn-shanghai.cr.aliyuncs.com/pai-eas/pai-rag:0.2.0-nginx"
      port   = 8680
      script = "/docker-entrypoint.sh nginx"
    },
    # UI容器
    {
      image  = "eas-registry-vpc.cn-shanghai.cr.aliyuncs.com/pai-eas/pai-rag:0.2.0-ui"
      port   = 8002,
      script = "pai_rag ui",
      env    = [{ name = "PAIRAG_RAG__SETTING__interactive", value = "false" }]
    },
    # 主服务容器
    {
      image  = "eas-registry-vpc.cn-shanghai.cr.aliyuncs.com/pai-eas/pai-rag:0.2.0"
      port   = 8001,
      script = "pai_rag serve",
      env    = [
        # 这里应包含所有环境变量配置
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__type", value = "PostgreSQL" },
        { name = "PAIRAG_RAG__INDEX__VECTOR_STORE__host", value = "pgm-uf6t7idr2x305eq7.pg.rds.aliyuncs.com" },
        # ...其他环境变量...
      ]
    }
  ]
}