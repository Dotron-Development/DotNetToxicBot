module "avm-res-cognitiveservices-account" {
  source              = "Azure/avm-res-cognitiveservices-account/azurerm"
  kind                = "OpenAI"
  location            = var.ai_location
  name                = "${local.appName}-ai-services-account-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "S0"

  cognitive_deployments = {
    "toxic_bot" = {
      name            = var.ai_model_name
      rai_policy_name = "all_high"
      model = {
        format  = "OpenAI"
        name    = var.ai_model_name
        version = var.ai_model_version
      }
      scale = {
        type     = "GlobalStandard"
        capacity = var.ai_capacity
      }
    },
  }

  rai_policies = {
    policy1 = {
      name             = "all_high"
      base_policy_name = "Microsoft.Default"
      mode             = "Asynchronous_filter"
      content_filters = [
        {
          name               = "Hate"
          blocking           = true
          enabled            = true
          severity_threshold = "High"
          source             = "Prompt"
        },
        {
          name               = "Sexual"
          blocking           = true
          enabled            = true
          severity_threshold = "High"
          source             = "Prompt"
        },
        {
          name               = "Violence"
          blocking           = true
          enabled            = true
          severity_threshold = "High"
          source             = "Prompt"
        },
        {
          name               = "Selfharm"
          blocking           = true
          enabled            = true
          severity_threshold = "High"
          source             = "Prompt"
        },
        {
          name               = "Hate"
          blocking           = true
          enabled            = true
          severity_threshold = "High"
          source             = "Completion"
        },
        {
          name               = "Sexual"
          blocking           = true
          enabled            = true
          severity_threshold = "High"
          source             = "Completion"
        },
        {
          name               = "Violence"
          blocking           = true
          enabled            = true
          severity_threshold = "High"
          source             = "Completion"
        },
        {
          name               = "Selfharm"
          blocking           = true
          enabled            = true
          severity_threshold = "High"
          source             = "Completion"
        }
      ]
    }
  }

  depends_on = [azurerm_resource_group.rg]
}
