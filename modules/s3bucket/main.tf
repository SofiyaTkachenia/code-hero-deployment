resource "aws_s3_bucket" "this" {
  bucket = "${var.base_name}-${var.env_name}"

  tags = {
    Name        = var.base_name
    Environment = var.env_name
  }
}
