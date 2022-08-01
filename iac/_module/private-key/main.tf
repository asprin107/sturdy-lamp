resource "tls_private_key" "rsa-4096bit" {
  algorithm = "RSA"
  rsa_bits  = 4096
}