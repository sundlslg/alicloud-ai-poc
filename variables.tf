variable "ali_access_key" {
  description = "阿里云 AccessKey"
  type        = string
  sensitive   = true
}

variable "ali_secret_key" {
  description = "阿里云 SecretKey"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "阿里云区域"
  type        = string
  default     = "cn-shanghai"
}