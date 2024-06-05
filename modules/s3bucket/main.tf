#======S3Bucket==================================================

resource "aws_s3_bucket" "this" {
  bucket = "${var.base_name}-s3-bucket"

  tags = {
    Name        = var.base_name
    Environment = var.env_name
  }
}
