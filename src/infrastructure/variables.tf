variable "environment" {
  description = "The environment for which the infrastructure is being provisioned (e.g., dev, prod)."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}
