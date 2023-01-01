variable "ecs_asg" {
  description = "Autoscaling Group as ECS node group info."
  type = object({
    name                      = string # asg name
    max_size                  = number # maximum size of scaling
    min_size                  = number # minimum size of scaling
    default_cooldown          = number
    default_instance_warmup   = number
    health_check_grace_period = number

    launch_template = object({
      name          = string
      instance_type = string
      arch          = string # X86_64 / ARM
      key_name      = string
      device_name   = string # /dev/xdva | /dev/sda
      volume_size   = number
      volume_type   = string # gp2

      sg_name        = string
      sg_description = string
      sg_rules = set(object({
        name        = string # Unique rule name for terraform index.
        type        = string # ingress / egress
        description = string
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = set(string)
      }))
    })
  })
}