output "jumphost-ip" {
  description = "The jumphost IP. Remember that the username is 'ubuntu'"
  value = google_compute_instance.bootcamp-instance.network_interface.0.access_config.0.nat_ip
}


output "private-key-name" {
  description = "The private key name needed to log into the jumphost"
  value = local_file.private_key.filename
  sensitive = false
}

output "public_key" {
  value = tls_private_key.ssh-key.public_key_openssh
  sensitive=true
}

output "vpc-id" {
  description = "The IP of the bootcamp VPC"
  value = google_compute_network.bootcamp-vpc.id
}

output "internal-vpc-security-all-bootcamp-ingress-firewall" {
  description = "Id of the google_compute_firewall for internal access"
  value = google_compute_firewall.all-bootcamp-ingress-firewall.id
}


output "internal-vpc-security-all-bootcamp-egress-firewall" {
  description = "Id of the google_compute_firewall for internal access"
  value = google_compute_firewall.all-bootcamp-egress-firewall.id
}

output "external-vpc-external-bootcamp-ingress-firewall-id" {
  description = "Id of the security group for external access"
  value = google_compute_firewall.external-bootcamp-ingress-firewall.id
}

output "public-subnet-ids" {
  description = "Public subnet for all external-facing instances"
  value = google_compute_subnetwork.bootcamp-public-subnet.*.id
}

output "private-subnet-ids" {
  description = "Subnet AZ1 for creating Confluent Cluster"
  value = google_compute_subnetwork.bootcamp-private-subnet.*.id
}
