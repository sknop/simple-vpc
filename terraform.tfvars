region = "eu-west-1"

vpc-cidr = "172.32.0.0/16"
public-subnet-cidr = [ "172.32.16.0/20", "172.32.32.0/20", "172.32.48.0/20" ]
private-subnets-cidr = [ "172.32.64.0/20", "172.32.80.0/20", "172.32.96.0/20" ]
public-availability-zones = [ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]
private-availability-zones = [ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]

jumphost-instance-type = "t3.micro"

bootcamp-key-name = "bootcamp-cc-key"


owner_email = "<<write your email here >>"
owner_name = "<<write your name here >>"