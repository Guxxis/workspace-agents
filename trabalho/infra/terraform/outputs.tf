output "jumphost_public_ip" {
  description = "O IP Público do Jumphost (Use no Ansible Inventory)"
  value       = digitalocean_droplet.jumphost.ipv4_address
}

output "jumphost_private_ip" {
  description = "O IP Privado (VPC) do Jumphost"
  value       = digitalocean_droplet.jumphost.ipv4_address_private
}
