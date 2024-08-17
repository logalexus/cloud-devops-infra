output "instance_private_ip_addresses" {
  description = "The private IP addresses of the instances."
  value       = { for name, vm in module.vm : name => vm.instance_private_ip_address }
}