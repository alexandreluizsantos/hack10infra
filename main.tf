terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.27.0"
    }
  }
}

# Configura o Provider Google Cloud com o Projeto
provider "google" {

  project = "hackathon-aso-gabarito"
  region  = "us-east4"
  zone    = "us-east4-c"
}

provider "google-beta" {
  project = "hackathon-aso-gabarito"
  region  = "us-east4"
  zone    = "us-east4-c"
}

resource "google_artifact_registry_repository" "my-repo" {
  provider = google-beta

  location = "us-east4"
  repository_id = "labdevops"
  description = "Imagens Docker"
  format = "DOCKER"
}

variable "database_password" {
type = string
}
variable "database_user" {
    type = string
}

resource "google_sql_database_instance" "instance" {
    name="spotmusic2"
    region="us-east4"
    database_version="MYSQL_8_0"
    deletion_protection = false
    settings{
        tier="db-f1-micro"
    }
}
resource "google_sql_database" "database"{
    name="playlist"
    instance=google_sql_database_instance.instance.name
}
resource "google_sql_user" "database-user" {
    name = var.database_user
    instance = google_sql_database_instance.instance.name
    password = var.database_password
}