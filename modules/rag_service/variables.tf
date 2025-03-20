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
