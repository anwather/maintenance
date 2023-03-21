param schedules array

resource schedule 'Microsoft.Maintenance/maintenanceConfigurations@2022-11-01-preview' = [for item in schedules: {
  name: item.name
  location: 'australiaeast'
  properties: {
    installPatches: {
      rebootSetting: item.rebootSetting
      windowsParameters: {
        classificationsToInclude: item.classifications
        kbNumbersToInclude: item.kbNumbersToInclude
        kbNumbersToExclude: item.kbNumbersToExclude
      }
    }
    extensionProperties: {
      InGuestPatchMode: 'User'
    }
    maintenanceScope: 'InGuestPatch'
    maintenanceWindow: item.maintenanceWindow
  }
}]
