Param ([string]$ResourceGroupName)

New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName `
    -TemplateFile .\maintenanceSchedule.bicep `
    -TemplateParameterFile .\maintenanceSchedule.parameters.jsonc `
    -Verbose