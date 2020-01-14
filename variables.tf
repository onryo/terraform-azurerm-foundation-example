variable "location" {
  default     = "westus"
  description = "Location/region to deploy resources"
}

variable "resource_group_name" {
  description = "Resource group name for shared network resources"
}

variable "vnet_name" {
  default     = "shared-vnet"
  description = "Virtual network name"
}

