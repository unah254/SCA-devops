# resource "google_compute_autoscaler" "autoscaler_config" {
#   provider = google-beta

#   name   = var.autoscaler_name
#   project = var.gcp["project"]
#   zone   = var.gcp["zone"]
#   target = google_compute_instance_group_manager.instance_manager.id

#   autoscaling_policy {
#     max_replicas    = var.max_replicas
#     min_replicas    = var.min_replicas
#     cooldown_period = 60
#   }
# }

resource "google_compute_instance_template" "instance_template" {
  provider = google-beta

  name           = var.instance_name
  project        = var.gcp["project"]
  machine_type   = var.instance_type
  can_ip_forward = false

  tags = ["foo", "bar"]

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
resource "google_compute_instance_from_template" "tpl" {
  name = "instance-from-template"
  zone = var.gcp["zone"]

  source_instance_template = google_compute_instance_template.instance_template.id

  project = var.gcp["project"]
  
}

# resource "google_compute_target_pool" "target_pool" {
#   provider = google-beta

#   name = "my-target-pool"

#   project = var.gcp["project"]
# }

# resource "google_compute_instance_group_manager" "instance_manager" {
#   provider = google-beta

#   name = "my-igm"
#   project = var.gcp["project"]
#   zone = var.gcp["zone"]

#   version {
#     instance_template = google_compute_instance_template.instance_template.id
#     name              = "primary"
#   }

#   target_pools       = [google_compute_target_pool.target_pool.id]
#   base_instance_name = "autoscaler-sample"
# }

data "google_compute_image" "debian_9" {
  provider = google-beta

  family  = "debian-9"
  project = "debian-cloud"
}

