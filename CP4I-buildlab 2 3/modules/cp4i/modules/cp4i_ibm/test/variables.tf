variable "ibmcloud_api_key" {
  description = "Enter your IBM API Cloud access key. Visit this link for more information: https://cloud.ibm.com/docs/account?topic=account-userapikey&interface=ui "
}

variable "cluster_id" {
  description = "ROKS cluster id. Use the ROKS terraform module or other way to create it"
}

variable "resource_group_name" {
  default     = "dteroks"
  type        = string
  description = "Resource group that the cluster is created in"
}

variable "region" {
    description = "Region where the cluster is hosted."
}

variable "storageclass" {
  default     = "ibmc-file-gold-gid"
  type        = string
  description = "Storage class to use.  If running on VPC, set to `portworx-rwx-gp3-sc` and make sure Portworx is set up on cluster"
}

variable "storage_class_rwo" {
  default     = "ibmc-block-gold"
  type        = string
  description = "Storage class to use.  If running on VPC, set to `portworx-rwx-gp3-sc` and make sure Portworx is set up on cluster"
}

variable "entitled_registry_user_email" {
  type        = string
  description = "Email address of the user owner of the Entitled Registry Key"
}

variable "entitled_registry_key" {
  type        = string
  description = "Get the entitlement key from https://myibm.ibm.com/products-services/containerlibrary"
}

variable "cluster_config_path" {
  default     = "./.kube/config"
  description = "Directory to store the kubeconfig file, set the value to empty string to not download the config. If running on Schematics, use `/tmp/.schematics/.kube/config`"
}

// ROKS Module : Local Variables and constants
locals {
  namespace        = "cp4i"
}