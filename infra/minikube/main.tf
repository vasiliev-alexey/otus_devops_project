terraform {
  required_version = ">= 0.12.26"
}




 


module "monitoring_infra" {
source = "../monitoring_module"
vm_depends_on = 0
}