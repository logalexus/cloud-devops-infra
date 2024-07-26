output "instance_id" {
  description = "Instance ID"
  value       = module.vm.instance_id
}

output "instance_public_ip" {
  description = "Public IP for VM"
  value       = module.vm.instance_public_ip_address
}