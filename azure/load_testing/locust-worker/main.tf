##############################################
######## Create worker Resource Group VNETs ########
##############################################

resource "random_string" "suffix" {
  length  = 3
  special = false
}


resource "azurerm_container_group" "worker" {
  name                = "locust-worker-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.rg_name
  ip_address_type     = "public"
  os_type             = "Linux"

  container {
    name   = "locust-worker"
    image  = "locustio/locust:2.5.0"
    cpu    = "2"
    memory = "2"
    commands = [
        "locust",
        "--locustfile",
        "/mnt/locust/locust.py",
        "--worker",
        "--master-host",
        var.master
    ]
    volume {
        name = "locust"
        git_repo { url = "https://github.com/skenderidis/config" }
        mount_path = "/mnt/locust/"
    }
    ports {
      port     = 8089
      protocol = "TCP"
    }
  }
  
  tags = {
    owner = var.tag
  }

}