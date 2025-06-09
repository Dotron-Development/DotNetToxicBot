variable "environment" {
  description = "The environment for which the infrastructure is being provisioned (e.g., dev, prod)."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}

variable "ai_model_name" {
  description = "The name of the AI model."
  type        = string
}

variable "ai_model_version" {
  description = "The name of the AI model version."
  type        = string
}

variable "ai_capacity" {
  description = "The capacity for the OpenAI service."
  type        = number
}
