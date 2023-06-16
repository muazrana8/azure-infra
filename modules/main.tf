resource "azurerm_virtual_network" "example" {
  name                = "my-virtual-network"
  address_space       = [var.virtual_network_cidr]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "public" {
  name                 = "public-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [var.public_subnet_cidr]
}

resource "azurerm_subnet" "private" {
  name                 = "private-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [var.private_subnet_cidr]
}

resource "azurerm_subnet_nat_gateway_association" "example" {
  subnet_id              = azurerm_subnet.public.id
  nat_gateway_id         = azurerm_nat_gateway.example.id
  depends_on             = [azurerm_subnet.public, azurerm_nat_gateway.example]
}

resource "azurerm_nat_gateway" "example" {
  name                      = "my-nat-gateway"
  location                  = azurerm_resource_group.example.location
  resource_group_name       = azurerm_resource_group.example.name
  public_ip_address_id      = azurerm_public_ip.example.id
  public_ip_prefix_id       = azurerm_public_ip_prefix.example.id
  idle_timeout_in_minutes   = 4
  allocated_outbound_ports   = 100
}

resource "azurerm_public_ip" "example" {
  name                = "my-public-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

resource "azurerm_public_ip_prefix" "example" {
  name                = "my-public-ip-prefix"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  prefix_length       = 29
  public_ip_address_version = "IPv4"
}

output "public_subnet_id" {
  value = azurerm_subnet.public.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private.id
}
