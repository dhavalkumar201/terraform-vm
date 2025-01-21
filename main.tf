resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  address_space       = var.vnet
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags

}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.subnet
}

resource "azurerm_public_ip" "public_ip" {
  count               = length(var.public_ip_name)
  name                = var.public_ip_name[count.index]
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method

  tags = var.tags
}

resource "azurerm_network_interface" "network_interface" {
  count               = length(var.nic_name)
  name                = var.nic_name[count.index]
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }

  tags = var.tags

}

resource "azurerm_linux_virtual_machine" "virtual_machine" {
  count               = length(var.vm_name)
  name                = var.vm_name[count.index]
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size[count.index]
  admin_username      = var.admin_username[count.index]
  network_interface_ids = [
    azurerm_network_interface.network_interface[count.index].id,
  ]

  admin_ssh_key {
    username   = var.admin_username[count.index]
    public_key = file("/home/einfochips/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = var.caching_method
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.sku_version
  }

  # connection {
  #   type     = "ssh"
  #   user     = var.admin_username[count.index]
  #   private_key = file("/home/einfochips/.ssh/id_rsa")
  #   host     = azurerm_public_ip.public_ip[count.index].ip_address
  # }

  # provisioner "file" {
  #   source = "/home/einfochips/Downloads/Repo/Terraform/azure/ip_addr.txt"
  #   destination = "/tmp/vm_ip_addr.txt"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get update",
  #     "sudo apt-get install -y azure-cli",
  #     "az login",
  #     "az account list",
  #     "az storage blob upload --account-name ${var.storage_account_name} --container-name ${var.storage_container_name} --name test1 --type block --content-type 'text/plain' --file /tmp/vm_ip_addr.txt"
  #   ]
  # }
  # provisioner "local-exec" {
  #   # command = "ansible -i inventory_azure_rm.yaml all -m ping -u adminuser --key-file /home/einfochips/.ssh/id_rsa"
  #   command = "ansible-playbook -i inventory_azure_rm.yaml -u adminuser --key-file /home/einfochips/.ssh/id_rsa demo.yml"
  # }
}