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
  type    = list(string)
  default = ["a", "b", "c"]
}

module "appA" {
  source          = "./mod"
  for_each        = toset(var.regions)
  generated_input = toset([each.key])
}

module "appB" {
  source          = "./mod"
  generated_input = toset([module.appA["a"].generated_output["a"].id])
}
