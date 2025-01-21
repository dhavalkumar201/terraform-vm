variable "location" {
  type    = string
  default = "Southeast Asia"
}
variable "resource_group_name" {
  type    = string
  default = "sa1_test_eic_ShivModi"
}
variable "vnet" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
variable "subnet" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}
variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}
variable "public_ip_address" {
  type    = string
  default = "Dynamic"
}
variable "publisher" {
  type    = string
  default = "Canonical"
}

variable "offer" {
  type    = string
  default = "0001-com-ubuntu-server-focal"
}

variable "sku" {
  type    = string
  default = "20_04-lts-gen2"
}

variable "sku_version" {
  type    = string
  default = "latest"
}

variable "size" {
  type    = list(string)
  default = ["Standard_B1s", "Standard_B2s"]
}

variable "admin_username" {
  type    = list(string)
  default = ["kube-master", "kube-worker"]
}

variable "vm_name" {
  type    = list(string)
  default = ["task-machine01", "task-machine02"]
}
variable "vnet_name" {
  type = string
  # default = "task-virtual-network"
}

variable "subnet_name" {
  type = string
}

variable "public_ip_name" {
  type    = list(string)
  default = ["Task-PublicIp01", "Task-PublicIp02"]
}

variable "allocation_method" {
  type    = string
  default = "Static"
}
variable "caching_method" {
  type    = string
  default = "ReadWrite"
}
variable "storage_account_type" {
  type    = string
  default = "Standard_LRS"
}
variable "nic_name" {
  type    = list(string)
  default = ["task-nic01", "task-nic02"]
}
variable "tags" {
  description = "Resources Tags"
}