# ----------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ----------------------------------------------------------------------------------------------------------------------

variable "name_suffix" {
  description = "An arbitrary suffix that will be added to the end of the resource name(s). For example: an environment name, a business-case name, a numeric id, etc."
  type        = string
  validation {
    condition     = length(var.name_suffix) <= 14
    error_message = "A max of 14 character(s) are allowed."
  }
}

variable "vpc_name" {
  description = "Name of the VPC Network for which this Serverless VPC Access connector will be created."
  type        = string
}

variable "ip_cidr_range" {
  description = "A non-overlapping /28 IP CIDR range that is unused by the VPC Netowrk elsewhere. The VPC Connector will create connector instances on IP addresses in this range."
  type        = string
}

# ----------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ----------------------------------------------------------------------------------------------------------------------

variable "connector_name" {
  description = "An arbitrary name for the Serverless VPC Access connector."
  type        = string
  default     = "vpc-connector"
}

variable "region" {
  description = "Region where the Serverless VPC Access connector resides. Defaults to the Google provider's region if nothing is specified here. See https://cloud.google.com/compute/docs/regions-zones"
  type        = string
  default     = ""
}

variable "connector_timeout" {
  description = "How long a VPC Connector operation is allowed to take before being considered a failure."
  type        = string
  default     = "10m"
}

variable "max_throughput" {
  description = "size of network throughput of the VPC Access Connector"
  type        = number
  default     = 1000
}