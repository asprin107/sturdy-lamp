locals {
  list_secrets_manager = csvdecode(file("../../_resources/lamp-bmt/secrets_manager.csv"))
}