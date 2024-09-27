locals {
  network_id  = "enp5aqgnh2ed37j3vo09"
  subnet_id   = "e9bud2skc42bn2h0vs1c"
  dns_zone_id = "dns2g7qg6f7aufer87vg"
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
  subnet_id   = local.subnet_id
  dns_zone_id = local.dns_zone_id
  instance_resources = {
    cores  = 2
    memory = 2
  }
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "gate"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "devops-route"
  network_id = local.network_id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}


