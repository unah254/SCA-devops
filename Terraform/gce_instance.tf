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
//updating the instances
resource "google_compute_instance_from_template" "tpl2" {
  depends_on = [
    google_compute_instance_template.instance_template
  ]
  name = "instance-from-template2"
  zone = var.gcp["zone"]

  source_instance_template = google_compute_instance_template.instance_template.id

  project = var.gcp["project"]
  
}
resource "google_compute_instance_from_template" "tpl3" {
  depends_on = [
    google_compute_instance_template.instance_template
  ]
  name = "instance-from-template3"
  zone = var.gcp["zone"]

  source_instance_template = google_compute_instance_template.instance_template.id

  project = var.gcp["project"]
  
}