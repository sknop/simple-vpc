output "private-key-name" {
  description = "The private key name needed to log into the jumphost"
  value = local_file.private_key.filename
}

output "jumphost-ip" {
  description = "The jumphost IP. Remember that the username is 'ubuntu'"
  value = aws_instance.jumphost.public_ip
}

output "database-private-ip" {
  description = "The database IP. This is the private IP address, only accessible from the jumphost"
  value = aws_instance.database.private_ip
}

output "vpc-id" {
  description = "The IP of the bootcamp VPC"
  value = module.vpc.vpc_id
}

output "internal-vpc-security-group-id" {
  description = "Id of the security group for internal access"
  value = aws_security_group.all-bootcamp.id
}

output "external-vpc-security-group-id" {
  description = "Id of the security group for external access"
  value = aws_security_group.external-access.id
}

output "public-subnet-ids" {
  description = "Public subnet for all external-facing instances"
  value = module.vpc.public_subnets
}

output "private-subnet-ids" {
  description = "Subnet AZ1 for creating Confluent Cluster"
  value = module.vpc.private_subnets
}

output "availability-zones" {
  description = "Availability zones corresponding to the subnet ids"
  value = [for az in module.vpc.azs : az]
}
