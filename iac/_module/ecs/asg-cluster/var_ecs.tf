variable "ecs" {
  description = "ECS cluster info."
  type = object({
    cluster_name           = string
    instance_warmup_period = number
    target_capacity        = number
  })
}