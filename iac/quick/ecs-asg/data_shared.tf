data "terraform_remote_state" "shared-resource" {
  backend = "s3"
  config = {
    bucket  = "lamp-bmt-tfstate"
    key     = "lamp-bmt-tfstate/base/shared-resource/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "bmt"
  }
}