locals {
  subnet_id   = "e9b2hvniretjviruoq61"
  dns_zone_id = "dns8jg2ig5tgnkhu0h54"
  vms = [
    "control-node1",
    "control-node2",
    "control-node3",
    "worker-node1",
    "worker-node2",
    "balancer-node",
  ]
}

module "vm" {
  source      = "../../terraform/modules/vm"
  for_each    = toset(local.vms)
  name        = each.key
  subnet_id   = local.subnet_id
  dns_zone_id = local.dns_zone_id
  instance_resources = {
    cores  = 2
    memory = 2
  }
}


