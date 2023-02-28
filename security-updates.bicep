resource def 'Microsoft.Maintenance/maintenanceConfigurations@2022-11-01-preview' = {
  name: 'security-updates'
  location: 'australiaeast'
  properties: {
    installPatches: {
      rebootSetting: 'Never'
      windowsParameters: {
        classificationsToInclude: [
          'Security'
        ]
      }
    }
    extensionProperties: {
      InGuestPatchMode: 'User'
    }
    maintenanceScope: 'InGuestPatch'
    maintenanceWindow: {
      startDateTime: '2023-02-28 00:00'
      duration: '03:00'
      timeZone: 'AUS Eastern Standard Time'
      recurEvery: '1Day'
    }
  }
}

output maintenanceConfigurationId string = def.id
