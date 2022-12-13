output "rsa-pub-key" {
  value = tls_private_key.rsa-4096bit.public_key_openssh
}

output "rsa-prv-key" {
  value = tls_private_key.rsa-4096bit.private_key_pem
}