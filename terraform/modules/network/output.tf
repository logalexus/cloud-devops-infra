output "subnet_id" {
  description = "ID for dns zone"
  value       = yandex_vpc_subnet.subnet.id
}