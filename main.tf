terraform {
  required_version = ">= 0.13.1" # see https://releases.hashicorp.com/terraform/
}

locals {
  connector_name   = format("%s-%s", var.connector_name, var.name_suffix)
  connector_region = var.region != "" ? var.region : data.google_client_config.google_client.region
}

resource "google_project_service" "networking_api" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "serverless_vpc_api" {
  service            = "vpcaccess.googleapis.com"
  disable_on_destroy = false
}

resource "google_vpc_access_connector" "vpc_connector" {
  name           = local.connector_name
  region         = local.connector_region
  network        = var.vpc_name
  machine_type   = var.machine_type
  min_instances  = var.min_instances
  max_instances  = var.max_instances
  max_throughput = var.max_throughput
  ip_cidr_range  = var.ip_cidr_range
  depends_on     = [google_project_service.networking_api, google_project_service.serverless_vpc_api]
  dynamic "subnet" {
    for_each = var.subnet == null ? [] : [0]
    content {
      name       = var.subnet
      project_id = var.project_id
    }
  }
  timeouts {
    create = var.connector_timeout
    delete = var.connector_timeout
  }
}

data "google_client_config" "google_client" {}
