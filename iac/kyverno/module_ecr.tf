module "ecr" {
  source = "../_module/ecr"

  name = "${var.project}-${var.service}"
}