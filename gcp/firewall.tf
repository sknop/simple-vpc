resource "google_compute_firewall" "all-bootcamp-ingress-firewall" {
  name    = "all-bootcamp-vpc-simple-ingress-firewall"
  network = google_compute_network.bootcamp-vpc.name

  allow {
    protocol = "all"
    #ports    = ["22", "9021", "80", "8088", "8089","18088","9092","8081","8090","18083"]
  }
  source_ranges = [var.vpc-cidr]
  direction = "INGRESS"
}

resource "google_compute_firewall" "all-bootcamp-egress-firewall" {
  name    = "all-bootcamp-vpc-simple-egress-firewall"
  network = google_compute_network.bootcamp-vpc.name

  allow {
    protocol = "all"
    #ports    = ["22", "9021", "80", "8088", "8089","18088","9092","8081","8090","18083"]
  }
  source_ranges = ["0.0.0.0/0"]
  direction = "EGRESS"
}

resource "google_compute_firewall" "external-bootcamp-ingress-firewall" {
  name    = "external-bootcamp-vpc-simple-ingress-firewall"
  network = google_compute_network.bootcamp-vpc.name

  allow {
    protocol = "all"
  }
  source_ranges = [local.my_ip]
  direction = "INGRESS"
}
