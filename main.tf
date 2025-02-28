provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "homelab_rg" {
  name     = "AzureHomeLab-RG"
  location = "East US"
}

resource "azurerm_virtual_network" "homelab_vnet" {
  name                = "homelab-vnet"
  location            = azurerm_resource_group.homelab_rg.location
  resource_group_name = "azurerm_resource_group.homelab_rg.name"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "homelab_subnet" {
  name                 = "homelab-subnet"
  resource_group_name  = "azurerm_resource_grou.homelab_rg.name"
  virtual_network_name = "azurerm_virtual_network.homelab_vnet.name"
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "homelab_nsg" {
  name                = "homelab-nsg"
  location            = "azurerm_resource_grou.homelab_rg.location"
  resource_group_name = "azurerm_resource_Group.homelab_rg.name"
}

resource "azurerm_public_ip" "homelab_ip" {
  name                = "homelab-ip"
  location            = "azurerm_resource_group.homelab_rg.location"
  resource_group_name = "azurerm_resource_group.homelab_rg.name"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "homelab_nic" {
  name                = "homelab-nic"
  location            = "azurerm_resource_group.homelab_rg.location"
  resource_group_name = "azurerm_resource_group.homelab_rg.name"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "azurerm_subnet.homelab_subnet.id"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "azurerm_public_ip.homelab_ip.id"
  }
}

resource "azurerm_windows_virtual_machine" "win11_vm" {
  name                  = "Win11-VM"
  resource_group_name   = "azurerm_resource_group.homelab_rg.name"
  location              = "azurerm_resource_group.homelab_rg.location"
  size                  = "Standard_B2ms"
  admin_username        = ""
  admin_password        = ""
  network_interface_ids = ["azurerm_network_interface.homelab_nic.id"]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-pro"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "winserver_vm" {
  name                  = "WinServer2019-VM"
  resource_group_name   = "azurerm_resource_group.homelab_rg.name"
  location              = "azurerm_resource_group.homelab_rg.location"
  size                  = "Standard_B2ms"
  admin_username        = ""
  admin_password        = ""
  network_interface_ids = ["azurerm_network_interface.homelab_nic.id"]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_storage_account" "homelab_storage" {
  name                     = "homelabstorage"
  resource_group_name      = "azurerm_resource_group.homelab_rg.name"
  location                 = "azurerm_resource_group.homelab_rg.location"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_log_analytics_workspace" "homelab_logs" {
  name                = "homelab-logs"
  location            = "azurerm_resource_group.homelab_rg.location"
  resource_group_name = "azurerm_resource_group.homelab_rg.name"
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

