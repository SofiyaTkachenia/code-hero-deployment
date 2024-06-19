module "solution_bucket" {
  source = "../../modules/s3bucket"

  base_name   = var.base_name
  bucket_name = var.solution_bucket_name
  env_name    = var.env_name
}

module "correct_output_bucket" {
  source = "../../modules/s3bucket"

  base_name   = var.base_name
  bucket_name = var.correct_output_bucket_name
  env_name    = var.env_name
}