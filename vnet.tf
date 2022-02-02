# Creación VNET Variables Zona A

### NETWORK ####
resource "azurerm_virtual_network" "vnet-a" {
  name                = "cl-${element(split(",", data.consul_keys.input.var.environment), 0)}-${element(split(",", data.consul_keys.input.var.regions), 0)}"
  location            = "${element(split(",", data.consul_keys.input.var.regions), 0)}"
  resource_group_name = "${element(split(",", data.consul_keys.input.var.resource_group_name), 0)}"
  address_space       = ["${element(split(",", data.consul_keys.input.var.address_space), 0)}"]
 
 tags = {
                applicationname         =   "${data.consul_keys.input.var.app-name}"
                deploymenttype          =   "${data.consul_keys.input.var.type}"
                environmentinfo         =   "${element(split(",", data.consul_keys.input.var.environment), 0)}"
                ownerinfo               =   "${data.consul_keys.input.var.owner}"
                ceco                    =   "${data.consul_keys.input.var.ceco}"
        }
}
resource "azurerm_subnet" "subnet-a-0" {
  name                      = "cl-a0-${element(split(",", data.consul_keys.input.var.environment), 0)}-${element(split(",", data.consul_keys.input.var.regions), 0)}-${random_string.id_a.result}"
  resource_group_name       = "${element(split(",", data.consul_keys.input.var.resource_group_name), 0)}"
  virtual_network_name      = "${azurerm_virtual_network.vnet-a.name}"
  address_prefix            = "${element(split(",", data.consul_keys.input.var.address_network), 0)}"
}



resource "azurerm_subnet" "subnet-a-1" {
  name                      = "cl-a1-${element(split(",", data.consul_keys.input.var.environment), 0)}-${element(split(",", data.consul_keys.input.var.regions), 0)}-${random_string.id_a.result}"
  resource_group_name       = "${element(split(",", data.consul_keys.input.var.resource_group_name), 0)}"
  virtual_network_name      = "${azurerm_virtual_network.vnet-a.name}"
  address_prefix            = "${element(split(",", data.consul_keys.input.var.address_network), 1)}"
}

resource "consul_keys" "output" {
  key {
    path  = "${var.consul_base_path}/output/random-string"
    value = "${random_string.id_a.result}"
  }
}
