// This is for creating a single instance
resource "google_compute_instance_from_template" "tpl" {
  depends_on = [
    google_compute_instance_template.instance_template
  ]
  name = "instance-from-template"
  zone = var.gcp["zone"]

  source_instance_template = google_compute_instance_template.instance_template.id

  project = var.gcp["project"]
  
}