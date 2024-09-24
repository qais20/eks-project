# Create the AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_vm_size
    vnet_subnet_id = var.subnet_id
    type                = "VirtualMachineScaleSets"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks-managed-identity.id]
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_user_assigned_identity" "aks-managed-identity" {
  name                = "aks-managed-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = var.scope
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks-managed-identity.principal_id
}