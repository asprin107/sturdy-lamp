resource "aws_ecr_repository" "ecr" {
  name = local.naming_convention

  image_scanning_configuration {
    scan_on_push = false
  }
}