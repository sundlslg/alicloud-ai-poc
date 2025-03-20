variable "llm_config" {
  description = "LLM 服务配置参数"
  type = object({
    instance_type  = string
    model_name     = string
    gpu_count      = number
    memory_size    = number
    network_config = object({
      vpc_id            = string
      vswitch_id        = string
      security_group_id = string
      region            = optional(string)
    })
  })
}
