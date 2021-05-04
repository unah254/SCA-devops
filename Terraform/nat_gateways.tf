resource "google_compute_router" "nat-router-us-central1" {
  name    = "nat-router-us-central1"
  region  = var.gcp["region"]
  network  = "default"
}

resource "google_compute_router" "nat-router-europe-west1" {
  name    = "nat-router-europe-west1"
  region  = var.gcp["region2"]
  network  = "default"

}


resource "google_compute_router_nat" "nat-config1" {
  depends_on = [
    google_compute_router.nat-router-us-central1
  ]
  name                               = "nat-config1"
  router                             = google_compute_router.nat-router-us-central1.name
  region                             = var.gcp["region"]
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_router_nat" "nat-config2" {
  depends_on = [
    google_compute_router.nat-router-europe-west1
  ]
  name                               = "nat-config2"
  router                             = google_compute_router.nat-router-europe-west1.name
  region                             = var.gcp["region2"]
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}