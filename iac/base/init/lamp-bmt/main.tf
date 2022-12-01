module "backend" {
  source = "../../../_module/init/backend-s3"

  profile = var.profile
  project = var.project
}