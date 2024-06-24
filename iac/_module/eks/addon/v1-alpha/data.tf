data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "http" "current_ip" {
  url = "https://ipinfo.io/ip"
}