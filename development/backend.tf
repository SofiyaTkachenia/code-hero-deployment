terraform {
  backend "s3" {
    bucket = "code-hero"
    key    = "s3bucket/dev/terraform.tfstate"
    region = "eu-central-1"
  }
}