provider "ibm" {
   region  = var.region
   ibmcloud_api_key = var.ibmcloud_api_key
}
data "ibm_resource_group" "group" {
  name = var.resource_group_name
}

resource "null_resource" "mkdir_kubeconfig_dir" {
  triggers = { always_run = timestamp() }
  provisioner "local-exec" {
    command = "mkdir -p ${var.cluster_config_path}"
  }
}

data "ibm_container_cluster_config" "cluster_config" {
  depends_on        = [null_resource.mkdir_kubeconfig_dir]
  cluster_name_id   = var.cluster_id
  resource_group_id = data.ibm_resource_group.group.id
  config_dir        = var.cluster_config_path
}

// Module:
module "cp4i" {
  source = "../../cp4i_ibm"

  // ROKS cluster parameters:
  cluster_config_path = data.ibm_container_cluster_config.cluster_config.config_file_path
  storageclass        = var.storageclass
  storage_class_rwo   = var.storage_class_rwo

  // Entitled Registry parameters:
  entitled_registry_key        = var.entitled_registry_key
  entitled_registry_user_email = var.entitled_registry_user_email

  namespace = "cp4i"
}