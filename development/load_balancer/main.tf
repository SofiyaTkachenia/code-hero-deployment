module "load_balancer" {
  source = "../../modules/alb"

  base_name            = var.base_name
  env_name             = var.env_name
  is_lb_internal       = var.is_lb_internal
  lb_security_group    = var.lb_security_group
  lb_subnets           = var.lb_subnets
  lb_target_group_arn  = var.lb_target_group_arn
  lb_target_group_port = var.lb_target_group_port
  lb_type              = var.lb_type
}