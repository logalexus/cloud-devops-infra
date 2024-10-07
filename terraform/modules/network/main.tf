locals {
  zone = "ru-central1-a"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "${var.name}-subnet"
  v4_cidr_blocks = [var.subnet_cidr]
  zone           = local.zone
  network_id     = var.network_id
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "${var.name}-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "${var.name}-route-table"
  network_id = var.network_id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}
