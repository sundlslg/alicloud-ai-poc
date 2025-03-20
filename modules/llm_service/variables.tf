# modules/llm_service/variables.tf
variable "llm_config" {
  description = "LLM服务配置参数"
  type = object({
    instance_type  = string
    model_name     = string
    gpu_count      = number
    memory_size    = number
    network_config = object({
      vpc_id            = string
      vswitch_id        = string
      security_group_id = string
    })
  })
}

# modules/llm_service/storage.tf
resource "alicloud_oss_bucket" "model_bucket" {
  bucket = "deepseek7b-model-bucket"
  acl    = "private"
}

# modules/llm_service/outputs.tf
output "llm_endpoint" {
  value = alicloud_pai_service.llm.service_endpoint
}