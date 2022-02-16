# Creación VNET Variables Zona A

### NETWORK ####
resource "azurerm_virtual_network" "vnet-a" {
  name                = "cl-${var.name}-${var.environment}-${var.regions}"
  location            = var.regions
  resource_group_name = var.resource_group_name
  address_space       = [var.address_spaces]
 
 tags = {
                applicationname         =   var.app-name
                deploymenttype          =   "Terraform"
                environmentinfo         =   var.environment
                ownerinfo               =   var.owner
                ceco                    =   var.ceco
        }
}
resource "azurerm_subnet" "subnet-a-0" {
  name                      = "cl-a0-${var.name}-${var.environment}-${var.regions}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet-a.name
  address_prefix            = "[${element(split(",", var.address_network), 0)}]"
}

resource "azurerm_subnet" "subnet-a-1" {
  name                      = "cl-a1-${var.name}-${var.environment}-${var.regions}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet-a.name
  address_prefix            = "[${element(split(",", var.address_network), 1)}]"
}

