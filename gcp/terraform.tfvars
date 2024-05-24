region = "europe-west2"
project = "partner-engineering"
credentials_file_path = "./partner-engineering-f8c9416b1675.json"

vpc-cidr = "172.32.0.0/16"
public-subnet-cidr = [ "172.32.16.0/20", "172.32.32.0/20", "172.32.48.0/20" ]
private-subnets-cidr = [ "172.32.64.0/20", "172.32.80.0/20", "172.32.96.0/20" ]
public-availability-zones = [ "europe-west2-a", "europe-west2-b", "europe-west2-c" ]
private-availability-zones = [ "europe-west2-a", "europe-west2-b", "europe-west2-c" ]

jumphost-instance-type = "n1-standard-4"

bootcamp-key-name = "simple-vpc-key"


owner_email = "ebalaguer@confluent.io"
owner_name = "Elena Molina"