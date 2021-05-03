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

variable "inputs" {
  type    = list(string)
  default = ["a", "b", "c"]
}

module "a" {
  source          = "./mod"
  for_each        = toset(var.inputs)
  generated_input = { each.key : null }
}

module "b" {
  source          = "./mod"
  generated_input = { module.a["a"].generated_output["a"].id : null }
}
