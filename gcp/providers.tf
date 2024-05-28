terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version     = "5.30.0"
    }
    curl = {
      version = "1.0.2"
      source  = "anschoewe/curl"
    }
  }

}

provider "google" {
  # Configuration options
  project     = var.project
  region      = var.region
}

provider "curl" {
}
