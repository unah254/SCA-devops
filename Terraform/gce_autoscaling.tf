//This is the template to create autoscaling group
resource "google_compute_autoscaler" "autoscaler_config" {
  depends_on = [
    google_compute_instance_group_manager.instance_manager
  ]
  provider = google-beta

  name   = var.autoscaler_name
  project = var.gcp["project"]
  zone   = var.gcp["zone"]
  target = google_compute_instance_group_manager.instance_manager.id

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = 60
  }
}
resource "google_compute_instance_group_manager" "instance_manager" {
  depends_on = [
    google_compute_instance_template.instance_template, google_compute_target_pool.target_pool
  ]
  provider = google-beta

  name = "my-igm"
  project = var.gcp["project"]
  zone = var.gcp["zone"]

  version {
    instance_template = google_compute_instance_template.instance_template.id
    name              = "primary"
  }

  target_pools       = [google_compute_target_pool.target_pool.id]
  base_instance_name = "autoscaler-sample"
}
resource "google_compute_target_pool" "target_pool" {
  provider = google-beta

  name = "my-target-pool"

  project = var.gcp["project"]
}