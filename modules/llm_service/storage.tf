resource "alicloud_oss_bucket" "model_storage" {
  bucket = "deepseek7b-model-storage"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }
}

resource "alicloud_oss_bucket_object" "model_files" {
  bucket = alicloud_oss_bucket.model_storage.bucket
  key    = "models/DeepSeek-R1-Distill-Qwen-7B/"
  source = "/dev/null"  # 实际应替换为模型文件路径
}