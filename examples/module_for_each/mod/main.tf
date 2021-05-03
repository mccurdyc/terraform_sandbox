variable "generated_input" {
  type = map(map(string))
}

locals {
  # motivation for this pattern came from https://github.com/terraform-google-modules/terraform-google-network/blob/d88508f7e1cb11fe6a07f503da7dc98bef58c99d/modules/routes/main.tf
  generated_input = {
    for input in var.generated_input :
    lookup(input, "region", "default") => input
  }
}

data "null_data_source" "generated" {
  for_each = local.generated_input
  inputs = {
    region = each.value.value
  }
}

output "generated_outputs" {
  value = {
    for output in data.null_data_source.generated :
    lookup(output.outputs, "region", "default") => {
      "region" : lookup(output.outputs, "region", "default")
      "value" : format("%s%s", lookup(output.outputs, "region", "default"), lookup(output.outputs, "region", "default"))
    }
  }
}
