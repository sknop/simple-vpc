resource "google_compute_address" "bootcamp-instance-address" {
  name         = "simple-vpc-vm-nic"
  address_type = "EXTERNAL"
}

resource "google_compute_instance" "bootcamp-instance" {
  depends_on = [tls_private_key.ssh-key]
  name         = "gcp-jumphost"
  machine_type = var.jumphost-instance-type
  zone         = var.public-availability-zones[0]

  boot_disk {
    initialize_params {
      type  = "pd-standard"
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
      size  = 50
    }
  }

  network_interface {
    network = google_compute_network.bootcamp-vpc.self_link
    subnetwork = google_compute_subnetwork.bootcamp-public-subnet[0].self_link

    access_config {
      nat_ip = google_compute_address.bootcamp-instance-address.address
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.ssh-key.public_key_openssh}"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = tls_private_key.ssh-key.private_key_pem
  }

}
