# Tools Required

- PowerShell 7
- Az.Resources module - 6.5.1
- Az.ResourceGraph module 0.13.0
- Bicep - 0.14.85

# Maintenance Schedules

Use the ```maintenanceSchedule.parameters.jsonc``` file to input required maintenance schedules. For each field that has a selection of values they are provided in the comments. For the ```recurEvery``` field see the [online documentation](https://learn.microsoft.com/en-us/azure/templates/microsoft.maintenance/maintenanceconfigurations?pivots=deployment-language-arm-template#maintenanceWindow-1).

To deploy the maintenance schedules use the method below.

```
Connect-AzAccount
Select-AzSubscription <<subscription for schedules to be created>>
New-AzResourceGroup -Name <<resource group name to be created>> -Location australiaeast
Deploy-MaintenanceSchedules.ps1 -ResourceGroupName <<resource group for schedules to be placed in>>
```

# Tagging Machines

For a machine to be targeted by a maintenance schedule it must be tagged as follows:

```
PatchingGroup: <<maintenance schedule name>>
```

This makes a machine available to be targeted however the script below must be run to create the assignment. 

# Configuration Assignments

Use the script below to retrieve machines which have a ```PatchingGroup``` tag and assign them to their maintenance schedules.

```
Deploy-ConfigurationAssignment.ps1
```