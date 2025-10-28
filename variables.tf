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
  default     = null
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

variable "subnet" {
  description = "Subnet to use for serverless connector. Only way in case of shared vpc connector."
  type        = string
  default     = null
}

variable "subnet_project_id" {
  description = "Project id of the subnet. Only required if subnet is in another shared host project."
  type        = string
  default     = null
}

variable "machine_type" {
  description = "Machine type of VM Instance underlying connector. Default is e2-micro. Refer to this doc for selecting machine type https://cloud.google.com/vpc/docs/serverless-vpc-access#scaling"
  type        = string
  default     = "e2-micro"
}

variable "min_instances" {
  description = "Minimum value of instances in autoscaling group underlying the connector. Value must be between 2 and 9, inclusive. Must be lower than the value specified by max_instances. Refer to this doc for setting min_instances https://cloud.google.com/vpc/docs/serverless-vpc-access#scaling."
  type        = number
  default     = 2
}

variable "max_instances" {
  description = "Maximum value of instances in autoscaling group underlying the connector. Value must be between 3 and 10, inclusive. Must be higher than the value specified by min_instances. Connectors don't scale in. To prevent connectors from scaling out more than you want, set the maximum number of instances to a low number. Refer to this doc for setting max_instances https://cloud.google.com/vpc/docs/serverless-vpc-access#scaling."
  type        = number
  default     = 3
}

variable "max_throughput" {
  description = "(Optional) Maximum throughput of the connector in Mbps, must be greater than min_throughput. Default is 300. Refers to the expected throughput when using an e2-micro machine type. Value must be a multiple of 100 from 300 through 1000. Must be higher than the value specified by min_throughput. If both max_throughput and max_instances are provided, max_instances takes precedence over max_throughput. The use of max_throughput is discouraged in favor of max_instances."
  type        = number
  default     = null
}
