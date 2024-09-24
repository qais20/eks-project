resource "azurerm_dns_zone" "hamidhirsi" {
  name                = var.dns_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_public_ip" "ingress_nginx_pip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_dns_a_record" "ingress" {
  name                = var.a_record_name
  zone_name           = azurerm_dns_zone.hamidhirsi.name
  resource_group_name = var.resource_group_name
  ttl                 = var.a_record_ttl
  records             = [azurerm_public_ip.ingress_nginx_pip.ip_address]
  depends_on = [
    azurerm_public_ip.ingress_nginx_pip
  ]
}

