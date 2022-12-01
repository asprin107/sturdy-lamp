locals {
  list_ecr = csvdecode(file("../../_resources/lamp-bmt/ecr.csv"))
}