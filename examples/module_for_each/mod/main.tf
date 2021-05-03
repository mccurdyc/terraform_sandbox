variable "generated_input" {
  type = map(string)
}

resource "null_resource" "generated" {
  for_each = var.generated_input
  provisioner "local-exec" {
    command = "echo ${each.key}"
  }
}

output "generated_output" {
  value = null_resource.generated
}
