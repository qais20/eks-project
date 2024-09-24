# Define input variables
variable "aks_name" {
  description = "Name of the project"
  type        = string
}

variable "dns_prefix" {
  description = "Name of the project"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location for the AKS cluster"
  type        = string
  default     = "East US"
}

variable "subnet_id" {
  description = "ID of the subnet where AKS will be deployed"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the AKS cluster"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "VM size for the AKS nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "scope" {
  description = "The scope at which the role assignment applies (e.g., resource group, subscription, or specific resource)"
  type        = string
}

variable "environment" {
  description = "ID of the subnet where AKS will be deployed"
  type        = string
}