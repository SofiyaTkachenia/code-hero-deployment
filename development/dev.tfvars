aws_region = "eu-central-1"
base_name = "code-hero"
env_name = "dev"

base_problem_registry_queue_name = "problem-registry"
base_java_17_verifier_queue_name = "java-17-verifier"
delay_seconds = 10

cloud_watch_retention_days = 1

aws_lb_listener_arn = "arn:aws:elasticloadbalancing:eu-central-1:175222917203:listener/app/code-hero/cc4474cb66899de8/5a821f19fff904b2"
aws_lb_target_group_arn = "arn:aws:elasticloadbalancing:eu-central-1:175222917203:targetgroup/java-17-verifier-target-group/0371bdeba482efc1"
cluster_arn = "arn:aws:ecs:eu-central-1:175222917203:cluster/cluster1"
cluster_id = "cluster1"

task_ecr_image_uri = "175222917203.dkr.ecr.eu-central-1.amazonaws.com/shop-dev-shippings:ARM" #Now it's dummy

task_container_port = 8081
task_host_port = 8081

memory_mb = 2048
vcpus = 1024

sidecar_container_image = "public.ecr.aws/aws-observability/aws-otel-collector:v0.33.0"
sidecar_container_container_port = 4317
sidecar_container_host_port = 4317

ecs_subnets = ["subnet-0a9f9dbf547745da4", "subnet-00404aca7fed5e2cb",
  "subnet-0e576f0b60a079911", "subnet-0805a3dc1028fafcc"]
ecs_security_group = ["sg-0e14b556ae4ffb184"]
