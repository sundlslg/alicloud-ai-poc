variable "llm_config" {
  type = object({
    instance_type     = string
    model_name        = string
    gpu_count         = number
    memory_size       = number
    network_config    = object({
      vpc_id            = string
      vswitch_id        = string
      security_group_id = string
    })
  })
}

resource "alicloud_pai_service" "llm" {
  service_name = "deepseek7b"
  service_type = "EAS"

  service_config = jsonencode({
    cloud = {
      computing = {
        instances = [{
          type = var.llm_config.instance_type
        }]
      }
      networking = var.llm_config.network_config
    }
    metadata = {
      cpu     = 16
      gpu     = var.llm_config.gpu_count
      memory  = var.llm_config.memory_size
      instance = 1
      name    = var.llm_config.model_name
    }
    storage = [{
      mount_path = "/model_dir/",
      oss = {
        endpoint = "oss-cn-shanghai-internal.aliyuncs.com",
        path     = "oss://pai-quickstart-cn-shanghai/modelscope/models/DeepSeek-R1-Distill-Qwen-7B"
      }
    }]
  })
}