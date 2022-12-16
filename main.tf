resource "vcd_vapp" "vapp" {
  name = var.vapp_name
  metadata = {
    Tag = "Managed by Terraform"
  }
}

resource "vcd_vapp_org_network" "vapp_network" {
  org              = var.org_name
  vdc              = var.org_vdc
  vapp_name        = vcd_vapp.vapp.name
  org_network_name = var.org_network
}

module "ubuntu-cloud-init-module" {
  for_each                        = var.vms
  source                          = "./ubuntu-cloud-init-module"
  mod_system_disk_bus             = var.system_disk_bus
  mod_system_disk_size            = var.system_disk_size
  mod_system_disk_storage_profile = var.system_disk_storage_profile
  mod_org_name                    = var.org_name
  mod_vapp_name                   = vcd_vapp.vapp.name
  mod_org_catalog                 = var.org_catalog
  mod_template_vm                 = var.template_vm
  mod_ci_user_name                = var.ci_user_name
  mod_ci_user_gecos               = var.ci_user_gecos
  mod_ci_user_ssh_pub             = var.ci_user_ssh_pub
  mod_ci_time_zone                = var.ci_time_zone
  mod_ci_user_passwd              = var.ci_user_passwd
  mod_ci_root_passwd              = var.ci_root_passwd
  mod_storage_profile             = var.storage_profile
  mod_org_network                 = var.org_network
  mod_add_disks                   = var.add_disks
  mod_vm_name                     = each.value.vm_name
  mod_ip_addr                     = each.value.ip_addr
  mod_vm_mem                      = each.value.vm_mem
  mod_vm_cpus                     = each.value.vm_cpus
}
