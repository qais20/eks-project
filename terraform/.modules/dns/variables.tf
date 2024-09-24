variable "dns_name" {
  description = "The DNS zone name"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The location of the public IP"
  type        = string
}

variable "public_ip_name" {
  description = "The name of the public IP"
  type        = string
}

variable "a_record_name" {
  description = "The A record name"
  type        = string
}

variable "a_record_ttl" {
  description = "The TTL for the A record"
  type        = number
  default     = 3600
}

