locals {
  subnet_id = "e9b2hvniretjviruoq61"
}

module "vm" {
  source          = "../modules/vm"
  name            = "vpn"
  subnet_id       = local.subnet_id
  use_external_ip = true
  instance_resources = {
    platform_id   = "standard-v2"
    cores         = 2
    memory        = 0.5
    core_fraction = 5
    disk = {
      image_id  = "fd8svrgm8prnu1qrksp5"
      disk_type = "network-hdd"
      disk_size = 5
    }
  }
}
