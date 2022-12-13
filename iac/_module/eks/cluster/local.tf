locals {
  tags   = merge(var.essential_tags, var.custom_tags)
  naming = "${var.essential_tags.Project}-${var.essential_tags.Service}-${var.essential_tags.Environment}"
}