#$output = New-AzResourceGroupDeployment -ResourceGroupName patching -TemplateFile .\definition-updates.bicep -Verbose
$output = New-AzResourceGroupDeployment -ResourceGroupName patching -TemplateFile .\security-updates.bicep -Verbose

# Definition Updates

$query = @'
resources
| where type == 'microsoft.compute/virtualmachines'
| where parse_json(tags).Updates == 'Definitions'
| project id
'@

$results = Search-AzGraph -Query $query

$results | Foreach-Object {
    $configurationAssignmentName = "$($_.id.split("/")[-1])-security_assignment"
    $body = @{
        properties = @{
            maintenanceConfigurationId = $output.Outputs.maintenanceConfigurationId.Value
        }
        location   = "australiaeast"
    }
    Invoke-AzRestMethod -Path "$($_.id)/providers/Microsoft.Maintenance/configurationAssignments/$configurationAssignmentName`?api-version=2021-09-01-preview" `
        -Method PUT `
        -Payload ($body | ConvertTo-Json)
}



