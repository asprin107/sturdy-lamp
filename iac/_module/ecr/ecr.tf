resource "aws_ecr_repository" "default" {
  name = local.naming_convention

  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}