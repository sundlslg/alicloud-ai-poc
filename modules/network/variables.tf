# modules/network/variables.tf
variable "region" {
  description = "阿里云区域"
  default     = "cn-shanghai"
}

variable "vpc_id" {
  description = "预创建的VPC ID"
  default     = "vpc-uf6184b3itp9n5ibyl6m2"
}

variable "vswitch_id" {
  description = "预创建的虚拟交换机ID"
  default     = "vsw-uf6e732h082u35ga53g3t"
}

variable "security_group_id" {
  description = "安全组ID"
  default     = "sg-uf6dsc3xyazqvsagweb2"
}

# modules/network/outputs.tf
output "network_config" {
  value = {
    vpc_id            = var.vpc_id
    vswitch_id        = var.vswitch_id
    security_group_id = var.security_group_id
    region            = var.region
  }
}