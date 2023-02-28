resource def 'Microsoft.Maintenance/maintenanceConfigurations@2022-11-01-preview' = {
  name: 'definition-updates'
  location: 'australiaeast'
  properties: {
    installPatches: {
      rebootSetting: 'Never'
      windowsParameters: {
        classificationsToInclude: [
          'Definition'
        ]
      }
    }
    extensionProperties: {
      InGuestPatchMode: 'User'
    }
    maintenanceScope: 'InGuestPatch'
    maintenanceWindow: {
      startDateTime: '2023-02-28 00:00'
      duration: '01:10'
      timeZone: 'AUS Eastern Standard Time'
      recurEvery: '6Hour'
    }
  }
}

output maintenanceConfigurationId string = def.id
