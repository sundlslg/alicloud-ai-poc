output "vpc_id" {
  description = "VPC ID"
  value       = var.vpc_id
}

output "vswitch_id" {
  description = "虚拟交换机 ID"
  value       = var.vswitch_id
}

output "security_group_id" {
  description = "安全组 ID"
  value       = var.security_group_id
}

output "region" {
  description = "区域信息"
  value       = var.region
}
