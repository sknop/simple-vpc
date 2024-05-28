resource "google_compute_network" "bootcamp-vpc" {
  name = "simplevpc"
  auto_create_subnetworks = false
}

resource "google_compute_router" "bootcamp-router" {
  name          = "simple-vpc-nat-router"
  region        = var.region
  network       = google_compute_network.bootcamp-vpc.self_link
}

resource "google_compute_address" "bootcamp-vpc_nat_ip" {
  name   = "simple-vpc-nat-egress-nat-ip"
  region = var.region
}

resource "google_compute_router_nat" "bootcamp-vpc_nat" {
  name                               = "simple-vpc-egress-natt"
  router                             = google_compute_router.bootcamp-router.name
  region                             = google_compute_router.bootcamp-router.region

  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.bootcamp-vpc_nat_ip.*.self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  /*subnetwork {
    name                    = google_compute_subnetwork.bootcamp-private-subnet[0].id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }*/
  subnetwork {
    name                    = google_compute_subnetwork.bootcamp-public-subnet[0].id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}


resource "google_compute_subnetwork" "bootcamp-private-subnet" {
  count         = length(var.private-subnets-cidr)
  name          = "simple-vpc-private-subnet-${count.index}"
  ip_cidr_range = element(var.private-subnets-cidr, count.index)
  region        = var.region
  network       = google_compute_network.bootcamp-vpc.id
}



resource "google_compute_subnetwork" "bootcamp-public-subnet" {
  count         = length(var.public-subnet-cidr)
  name          = "simple-vpc-public-subnet-${count.index}"
  ip_cidr_range = element(var.public-subnet-cidr, count.index)
  region        = var.region
  network       = google_compute_network.bootcamp-vpc.id
}



resource "google_compute_global_address" "bootcamp-service_access_address" {

  name    = "vpc-simple-private-service-access"
  network = google_compute_network.bootcamp-vpc.id

  purpose      = "PRIVATE_SERVICE_CONNECT"
  address_type = "INTERNAL"

  address       = "172.32.112.0"
}