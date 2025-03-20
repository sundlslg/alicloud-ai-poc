// 定义网络配置输出
output "network_config" {
  value = {
    vpc_id            = var.vpc_id
    vswitch_id        = var.vswitch_id
    security_group_id = var.security_group_id
    region            = var.region
  }
}
