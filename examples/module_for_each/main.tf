terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "null" {
  # Configuration options
}

variable "regions" {
  type = map(map(string))
  default = {
    "a" : {
      "region" : "a",
      "value" : "a",
    },
    "b" : {
      "region" : "b",
      "value" : "b",
    },
  }
}

module "appA" {
  source          = "./mod"
  generated_input = var.regions
}

module "appB" {
  source          = "./mod"
  generated_input = module.appA.generated_outputs
}

output "foo" {
  value = module.appB.generated_outputs
}
