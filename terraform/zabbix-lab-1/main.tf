locals {
  subnet_id = "e9b2hvniretjviruoq61"
  dns_zone_id = "dns8jg2ig5tgnkhu0h54"
  vm_names  = ["zabbix", "web"]  
}

module "vm" {
  source          = "../modules/vm"
  for_each        = toset(local.vm_names)
  name            = each.key
  subnet_id       = local.subnet_id
  dns_zone_id       = local.dns_zone_id
  instance_resources = {
    cores         = 2
    memory        = 2
  }
}

