resource "azurerm_resource_group" "shared-rg" {
  name     = "shared-rg"
  location = "East US"
}

module "vnet" {
  source                = "./.modules/vnet"
  vnet_name             = local.vnet_name
  subnet_name           = local.subnet_name
  resource_group_name   = local.rg_name
  location              = local.location
  environment           = local.environment
  vnet_address_space    = ["10.1.0.0/16"]
  subnet_address_prefix = ["10.1.1.0/24"]
}

module "acr" {
  source              = "./.modules/acr"
  acr_name            = local.acr_name
  resource_group_name = local.rg_name
  location            = local.location
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = module.aks.kubelet_identity
  role_definition_name = "AcrPull"
  scope                = module.acr.acr_id
  depends_on           = [module.acr]
}

module "aks" {
  source              = "./.modules/aks"
  aks_name            = local.aks_name
  dns_prefix          = "aksprod"
  environment         = local.environment
  resource_group_name = local.rg_name
  scope               = local.rg_id
  location            = local.location
  node_count          = 2
  node_vm_size        = "Standard_DS2_v2"
  subnet_id           = module.vnet.subnet_id
  depends_on          = [module.vnet]
}

# data "azurerm_kubernetes_cluster" "main_aks" {
#   name                = local.aks_name
#   resource_group_name = local.rg_name
#   depends_on = [
#     module.aks.HamidAKSCluster
#   ]
# }

module "dns" {
  source              = "./.modules/dns"
  dns_name            = local.dns_name
  a_record_name = "app"
  public_ip_name = "ingress-nginx-ip"
  resource_group_name = local.rg_name
  location            = local.location
}

module "selfhost" {
  source              = "./.modules/selfhost"
  resource_group_name = "selfhost-rg"
  location            = "East US"
  vnet_name           = "my-vnet"
  subnet_name         = "my-subnet"
  nic_name            = "my-nic"
  vm_name             = "azureagent"
  computer_name       = local.computer_name
  admin_username      = local.admin_username
  admin_password      = local.admin_password
  script              = local.script
}
