variable "generated_input" {
  type = map(map(string))
}

locals {
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
