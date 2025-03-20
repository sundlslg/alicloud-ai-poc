variable "region" {
  default = "cn-shanghai"
}

variable "vpc_id" {
  default = "vpc-uf6184b3itp9n5ibyl6m2"
}

variable "vswitch_id" {
  default = "vsw-uf6e732h082u35ga53g3t"
}

variable "security_group_id" {
  default = "sg-uf6dsc3xyazqvsagweb2"
}

output "network_config" {
  value = {
    vpc_id            = var.vpc_id
    vswitch_id        = var.vswitch_id
    security_group_id = var.security_group_id
    region            = var.region
  }
}