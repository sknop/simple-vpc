terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
      version     = "5.27.0"
    }
    google = {
      source = "hashicorp/google"
      version     = "5.27.0"
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
  credentials = var.credentials_file_path
}

provider "google-beta" {
  # Configuration options
  project     = var.project
  region      = var.region
  credentials = var.credentials_file_path
}

provider "curl" {
}