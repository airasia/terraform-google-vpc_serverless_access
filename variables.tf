variable "name_suffix" {
  description = "An arbitrary suffix that will be added to the end of the resource name(s). For example: an environment name, a business-case name, a numeric id, etc."
  type        = string
  validation {
    condition     = length(var.name_suffix) <= 14
    error_message = "A max of 14 character(s) are allowed."
  }
}

variable "vpc_network_name" {
  description = "VPC Network Name"
  type        = string
}

variable "vpc_connector_region" {
  description = "VPC Conector Region"
  type        = string
}

variable "ip_cidr_range" {
  description = "VPC Connector CIDR IP"
  type        = string
}

variable "vpc_connector_timeout" {
  description = "How long a VPC Connector operation is allowed to take before being considered a failure."
  type        = string
  default     = "10m"
}
