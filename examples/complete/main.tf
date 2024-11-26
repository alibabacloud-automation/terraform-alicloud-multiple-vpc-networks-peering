module "complete" {
  source = "../.."

  vpcs = {
    cidr_block = ["10.0.0.0/16", "192.168.0.0/16", "10.4.0.0/16"]
  }
}
