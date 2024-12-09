
/* resource "azurerm_linux_virtual_machine_scale_set" "example" {

  name                = "k8s-vmss"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                = "Standard_F2"
  instances           = 1
  admin_username       = "adminuser_worker"
  admin_password      = "Holapepito1@" # Define la contraseña aquí
  disable_password_authentication = false
 

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.worker.id
    }
  }
}

*/

# master_vm.tf
resource "azurerm_network_interface" "worker_1" {
  name                = "workerNIC"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.worker.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.worker_public_ip.id

  }
}

resource "azurerm_public_ip" "worker_public_ip" {
  name                = "workerPublicIP"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static" # O "Static" si prefieres una IP fija
}


resource "azurerm_linux_virtual_machine" "worker" {
  name                = "workerVM"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser_worker"
  admin_password      = "Holapepito1@" # Define la contraseña aquí

  network_interface_ids = [
    azurerm_network_interface.worker_1.id,
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  disable_password_authentication = false  # Asegúrate de que la autenticación por contraseña esté permitida



  
}
