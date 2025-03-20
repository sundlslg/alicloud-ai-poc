variable "region" {
  description = "阿里云区域"
  default     = "cn-shanghai"
}

variable "vpc_id" {
  description = "预创建的 VPC ID"
  default     = "vpc-uf6184b3itp9n5ibyl6m2"
}

variable "vswitch_id" {
  description = "预创建的虚拟交换机 ID"
  default     = "vsw-uf6e732h082u35ga53g3t"
}

variable "security_group_id" {
  description = "安全组 ID"
  default     = "sg-uf6dsc3xyazqvsagweb2"
}