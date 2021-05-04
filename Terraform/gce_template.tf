// This is the template to create a gce instance
data "google_compute_image" "debian_9" {
  provider = google-beta

  family  = "debian-9"
  project = "debian-cloud"
}
resource "google_compute_instance_template" "instance_template" {
  provider = google-beta

  name           = var.instance_name
  project        = var.gcp["project"]
  machine_type   = var.instance_type
  can_ip_forward = false
  metadata_startup_script = "sudo apt-get update -y && sudo apt install nginx -y"


  disk {
    source_image = data.google_compute_image.debian_9.id
  }

  network_interface {
    network = "default"
  }

  metadata = {
    foo = "bar"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}