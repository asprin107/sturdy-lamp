locals {
  list_sg = yamldecode(file("../../_resources/lamp-bmt/security_groups.yaml"))
}