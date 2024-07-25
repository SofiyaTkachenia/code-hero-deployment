aws_region = "eu-central-1"
base_name  = "code-hero"
env_name   = "dev"

cloud_watch_retention_days   = 1
message_delay_period_seconds = 10
queue_visibility_timeout_seconds = 60

java17_sqs_queue             = "java17_sqs_queue"
image_url                   = "175222917203.dkr.ecr.eu-central-1.amazonaws.com/lambda:latest"
java17_compiler_lambda_name = "java17_compiler"
lambda_timeout_seconds      = 60
lambda_memory_mb            = 512
subnet_id                   = ["subnet-00404aca7fed5e2cb"]
security_group_ids          = ["sg-02a868ed870c657f4"]

s3_put_object_bucket_arn = "arn:aws:s3:::code-hero-compiled-files"
s3_get_object_bucket_arn = "arn:aws:s3:::code-hero-solutions"
send_messages_queue_arn  = "arn:aws:sqs:eu-central-1:175222917203:code-hero-problem-registry-dev"