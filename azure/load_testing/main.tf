resource "random_string" "suffix" {
  length  = 3
  special = false
}


# Create a resource group
resource "azurerm_resource_group" "load_rg_master" {
  name     = "Load-master-${random_string.suffix.result}"
  location = var.location
  tags = {
    owner = var.tag
  }
}

resource "azurerm_container_group" "master" {
  name                = "locust-master"
  location            = azurerm_resource_group.load_rg_master.location
  resource_group_name = azurerm_resource_group.load_rg_master.name
  ip_address_type     = "public"
  dns_name_label      = "f5demo-${random_string.suffix.result}"
  os_type             = "Linux"

  container {
    name   = "locust-master"
    image  = "skenderidis/locust-hackazon"
#    image  = "locustio/locust:2.5.0"
    cpu    = "2"
    memory = "4"
    commands = [
        "locust",
        "--locustfile",
        "/mnt/locust/locustfile.py",
        "--master"
    ]
//    volume {
//        name = "locust"
//        git_repo { url = "https://github.com/skenderidis/config" }
//        mount_path = "/mnt/locust/"
//    }
    ports {
      port     = 8089
      protocol = "TCP"
    }
    ports {
      port     = 5557
      protocol = "TCP" 
    }
  }

  tags = {
    owner = var.tag
  }

}


module "load-east-us" {
  source    = "./locust-worker"
  location  = "eastus"
  rg_name   = azurerm_resource_group.load_rg_master.name
  master    = azurerm_container_group.master.fqdn
  count     = var.count_eastus
  tag       = var.tag
}
module "load-west-us" {
  source    = "./locust-worker"
  location  = "westus"
  rg_name   = azurerm_resource_group.load_rg_master.name
  master    = azurerm_container_group.master.fqdn
  count     = var.count_westus
  tag       = var.tag
}


module "load-west-eu" {
  source    = "./locust-worker"
  location  = "uksouth"
  rg_name   = azurerm_resource_group.load_rg_master.name
  master    = azurerm_container_group.master.fqdn
  count     = var.count_uksouth
  tag       = var.tag
}

module "load-asia" {
  source    = "./locust-worker"
  location  = "eastasia"
  rg_name   = azurerm_resource_group.load_rg_master.name
  master    = azurerm_container_group.master.fqdn
  count     = var.count_eastasia
  tag       = var.tag
}
