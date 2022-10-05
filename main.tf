#Create a GCP network and subnet
resource "google_compute_network" "vpc_network" {
  name                    = "my-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "default" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
}

# Create a single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "my-vm"
  machine_type = "f1-micro"
  zone         = "us-east1-b"
  project = "{PROJECT NAME HERE}"
  provider = "google"

  metadata = {
    enable-oslogin = "TRUE"
  }
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}