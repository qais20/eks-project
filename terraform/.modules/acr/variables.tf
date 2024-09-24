variable "acr_name" {
  description = "The name of the project for naming resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the ACR."
  type        = string
}

variable "location" {
  description = "The location/region where the ACR will be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry (Basic, Standard, Premium)."
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Enable admin access to the ACR."
  type        = bool
  default     = false
}
