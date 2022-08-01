module "ec2-key" {
  source      = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/ec2/key_pair"
  key_name    = var.ec2-key-name
  ec2_pub_key = module.key.rsa-pub-key
}