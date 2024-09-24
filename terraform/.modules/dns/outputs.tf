output "dns_zone_id" {
  value = azurerm_dns_zone.hamidhirsi.id
}

output "dns_a_record_fqdn" {
  value = azurerm_dns_a_record.ingress.fqdn
}

output "public_ip" {
  value = azurerm_public_ip.ingress_nginx_pip.ip_address
}