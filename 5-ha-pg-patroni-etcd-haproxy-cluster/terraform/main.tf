locals {
  subnet_id   = "e9b2hvniretjviruoq61"
  dns_zone_id = "dns8jg2ig5tgnkhu0h54"
  vms = [
    "cluster-01-pgsql",
    "cluster-02-pgsql",
    "cluster-03-pgsql",
    "cluster-01-etcd",
    "cluster-02-etcd",
    "cluster-03-etcd",
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


