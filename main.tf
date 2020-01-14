module "network" {
  source = "github.com/Azure/terraform-azurerm-network?ref=e099448e3ae33394d4e90ffd0cd5ad4a82ba96c7"

  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

resource "azurerm_subnet" "subnet" {
  name                      = "subnet1"
  address_prefix            = "10.0.1.0/24"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.vnet_name
  network_security_group_id = azurerm_network_security_group.ssh.id
}

resource "azurerm_network_security_group" "ssh" {
  depends_on          = [module.network]
  name                = "ssh"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

