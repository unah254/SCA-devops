terraform {
  required_version = "~> 0.14.0"
  backend "gcs" {
     bucket = "level-six"
     prefix  = "terraform/terraform.state"
  }
}

provider "google" {
  project     = var.gcp["project"]
  region      = var.gcp["region"]
}
provider "google-beta" {
 project     = var.gcp["project"]
 region      = var.gcp["region"]
}