module "ec2-key" {
  source      = "../../_module/ec2/key_pair"
  key_name    = var.ec2-key-name
  ec2_pub_key = module.key.rsa-pub-key
}