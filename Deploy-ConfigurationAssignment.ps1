$machineQuery = @'
resources
| where type == 'microsoft.hybridcompute/machines'
| where isnotempty(parse_json(tags).PatchingGroup) 
| project id,tags
'@

$results = Search-AzGraph -Query $machineQuery

$maintenanceConfigurationQuery = @'
resources
| where type == 'microsoft.maintenance/maintenanceconfigurations'
| project name,id
'@

$maintenanceConfiguration = Search-AzGraph -Query $maintenanceConfigurationQuery

$results | Foreach-Object {
    $body = @{
        properties = @{
            maintenanceConfigurationId = ($maintenanceConfiguration | Where-Object Name -eq $_.tags.PatchingGroup).id
        }
        location   = "australiaeast"
    }
    Write-Output "Assigning $($_.id.Split("/")[-1]) to maintenance schedule $($_.tags.PatchingGroup)"
    try {
        Invoke-AzRestMethod -Path "$($_.id)/providers/Microsoft.Maintenance/configurationAssignments/$($_.tags.PatchingGroup)`?api-version=2021-09-01-preview" `
            -Method PUT `
            -Payload ($body | ConvertTo-Json) `
            -ErrorAction Stop
    }
    catch {
        throw $_
    }
    
}



