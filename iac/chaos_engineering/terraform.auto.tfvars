rule = {
  host_cidr = "10.0.0.0/16"
  subnets = {
    newbits         = 6
    available_zones = ["a", "c"]
    pub = {
      amount = 2
      max    = 64
    }
  }
}