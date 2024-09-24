output "vm_id" {
  description = "The ID of the created virtual machine"
  value       = azurerm_virtual_machine.vm.id
}

output "vm_identity" {
  value = azurerm_virtual_machine.vm.identity[0].principal_id
}
