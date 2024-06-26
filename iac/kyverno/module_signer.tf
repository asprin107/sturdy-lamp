module "signer" {
  source = "../_module/signer"

  signer_profile_name = "${var.project}${title(var.service)}" // make camelcase. only alphanumeric available.
}