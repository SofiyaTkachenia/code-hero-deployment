output "queue_arn" {
  value = aws_sqs_queue.this.arn
}

output "queue_name" {
  value = aws_sqs_queue.this.name
}