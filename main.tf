terraform {
  required_version = ">= 0.13.1" # see https://releases.hashicorp.com/terraform/
}

locals {
  connector_name = format("%s-%s", var.connector_name, var.name_suffix)
}

resource "google_project_service" "serverless_vpc_api" {
  service            = "vpcaccess.googleapis.com"
  disable_on_destroy = false
}

resource "google_vpc_access_connector" "vpc_connector" {
  name          = local.connector_name
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
  network       = var.vpc_name
  depends_on    = [google_project_service.serverless_vpc_api]
  timeouts {
    create = var.vpc_connector_timeout
    update = var.vpc_connector_timeout
    delete = var.vpc_connector_timeout
  }
}

data "google_client_config" "google_client" {}
