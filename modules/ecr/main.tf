resource "aws_ecr_repository" "foo" {
  name                 = "${var.base_name}-${var.env_name}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}