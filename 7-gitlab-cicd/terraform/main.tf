locals {
  dns_zone_id = "dns2g7qg6f7aufer87vg"
  network_id = "enp5aqgnh2ed37j3vo09"
  vms = [
    "gitlab",
    "runner",
    "prod",
  ]
}

module "vm" {
  source      = "../../terraform/modules/vm"
  for_each    = toset(local.vms)
  name        = each.key
  subnet_id   = module.network.subnet_id
  dns_zone_id = local.dns_zone_id
  instance_resources = {
    cores  = 2
    memory = 2
  }
}

module "network" {
  source      = "../../terraform/modules/network"
  name        = "devops"
  network_id  = local.network_id
  subnet_cidr = "192.168.100.0/24"
}




