locals {
  first_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC87FxFeKTt4v6mB2XEcWfEyCa6SZ/c2v/MdgrpCikLZXHAnzKZ9BPTVdmhStY2mp9k4OQA8c/xOE2ea42YwTS6oI0yKf5oyWLkg593k1Il8+7i6aNTMxWMDwRIns2qFBTTUhSI3649I86SgDdCmvc++YZTL1wEw67eTN4TJgCcsgudVsxFElYv7MJLYNniMyvUC7KU4haC5Uvo2IZzOaHGCHtMhC8O/UTjHZTKNvaHcqCWNO9AfCRVUBvdaI2EjnreHTdV9cdZlt48u20DMHE/owOdJufO0cdmgOAF705FwV8NWnbAUp8pQ7C12CTS6Po5Sx0vA6pmCSS392/Ac1TSOSbeQpvmytggg3xpyNbOAWLJ6VpH3HK5S/TXUNzXoHclvm7iiN0DEcCk9D8rfVmR+16hDx8Ix93l2hix7UrBEi+TUg/E20aCmoYR+FGQO9TY+KkNQ9Z5ispGTuG1eP96XFWYJHtFCfDr+6HjXa/eH9twF2bW2iKvAnYWWYP5NAM= labtel@labtel"
}


resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                = "k8s-vmss"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = local.first_public_key
  }

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