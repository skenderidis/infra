



#########   Common Variables   ##########
variable tag 				  	  {}
variable username		  		{}
variable password		  		{}
variable location				  {}
variable rg_name  				{}


variable libs_dir         { default = "/config/cloud/azure/node_modules" }
variable onboard_log      { default = "/var/log/startup-script.log" }


variable "f5_instance_type" {}
variable "f5_image_name" {}
variable "f5_version" {}
variable "f5_product_name" {}



variable "prefix" {}
variable "tag" {}
variable "AS3_URL" {}
variable "DO_URL" {}
variable "TS_URL" {}
variable "CFE_URL" {}
variable "FAST_URL" {}
variable "INIT_URL" {}
variable "f5_password" {}
variable "f5_username" {}

variable "mgmt_subnet_id" {}
variable "int_subnet_id" {}
variable "ext_subnet_id" {}
variable "mgmt_nsg_id" {}
variable "ext_nsg_id" {}
variable "self_ip_mgmt" { }
variable "self_ip_ext" { }
variable "self_ip_int" { }
variable "add_ip_ext_1" { }

