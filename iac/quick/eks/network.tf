module "network" {
  source = "./_module/basic_network"

  project_name = "eks-test"
  region       = var.region
}