data "template_file" "userdata" {

  template = file("${path.module}/userdata.yml")
  vars = {
    ci_ansible_ssh_pub = "${var.mod_ci_ansible_ssh_pub}"
    ci_hostname        = "${var.mod_vm_name}"
    ci_instance_id     = "${var.mod_vm_name}"
  }
}

data "vcd_catalog" "my_cat" {
  org  = var.mod_org_name
  name = var.mod_org_catalog
}
