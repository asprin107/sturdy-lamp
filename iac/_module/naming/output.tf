output "name" {
  description = "Generated name."
  value = join(var.separator, compact([
    var.prefix,
    var.project,
    var.service,
    var.suffix,
    local.random_string
  ]))
}

output "random_string" {
  description = "This is a random string added to prevent collisions when newly created."
  value       = local.random_string
}

resource "random_string" "base" {
  length  = var.random_length
  special = false
  upper   = false
  numeric = false
}

locals {
  random_string = var.random_string == null ? random_string.base.result : var.random_string
}