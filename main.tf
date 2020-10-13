terraform {
  required_version = ">= 0.13.1" # see https://releases.hashicorp.com/terraform/
}

locals {
  connector_name = format("%s-%s", var.connector_name, var.name_suffix)
  connector_region = var.region != "" ? var.region : data.google_client_config.google_client.region
}

resource "google_project_service" "serverless_vpc_api" {
  service            = "vpcaccess.googleapis.com"
  disable_on_destroy = false
}

resource "google_vpc_access_connector" "vpc_connector" {
  name          = local.connector_name
  region        = local.connector_region
  network       = var.vpc_name
  ip_cidr_range = var.ip_cidr_range
  depends_on    = [google_project_service.serverless_vpc_api]
  timeouts {
    create = var.connector_timeout
    update = var.connector_timeout
    delete = var.connector_timeout
  }
}

data "google_client_config" "google_client" {}
