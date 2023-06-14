@description('Specifies the location for resources.')
param location string = 'West Europe'

param adminSourceIPRanges array = [
  '10.10.10.0/24'
  '10.20.20.0/24'
]

resource vnet 'Microsoft.Network/virtualNetworks@2022-09-01' = {
  name: 'myVNet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource webServerSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-09-01' = {
  name: 'webServerSubnet'
  parent: vnet
  properties: {
    addressPrefix: '10.0.1.0/24'
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Disabled'
  }
}

resource adminServerSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-09-01' = {
  name: 'adminServerSubnet'
  parent: vnet
  properties: {
    addressPrefix: '10.0.2.0/24'
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Disabled'
  }
}

resource webServerPublicIP 'Microsoft.Network/publicIPAddresses@2022-09-01' = {
  name: 'webServerPublicIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource adminServerPublicIP 'Microsoft.Network/publicIPAddresses@2022-09-01' = {
  name: 'adminServerPublicIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource webServerNIC 'Microsoft.Network/networkInterfaces@2022-09-01' = {
  name: 'webServerNIC'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          subnet: {
            id: webServerSubnet.id
          }
          publicIPAddress: {
            id: webServerPublicIP.id
          }
        }
      }
    ]
  }
}

resource adminServerNIC 'Microsoft.Network/networkInterfaces@2022-09-01' = {
  name: 'adminServerNIC'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          subnet: {
            id: adminServerSubnet.id
          }
          publicIPAddress: {
            id: adminServerPublicIP.id
          }
        }
      }
    ]
  }
}

resource webServerVM 'Microsoft.Compute/virtualMachines@2022-09-01' = {
  name: 'webServerVM'
  location: location
  dependsOn: [
    webServerNIC
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: [
        {
          createOption: 'Empty'
          diskSizeGB: 128
          encryptionSettings: {
            enabled: true
          }
        }
      ]
    }
    osProfile: {
      computerName: 'webserver'
      adminUsername: 'adminUser'
      adminPassword: 'yourAdminPassword'
      linuxConfiguration: {
        disablePasswordAuthentication: true
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: webServerNIC.id
        }
      ]
    }
  }
}

resource adminServerVM 'Microsoft.Compute/virtualMachines@2022-09-01' = {
  name: 'adminServerVM'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: 'adminserver'
      adminUsername: 'adminUser'
      adminPassword: 'yourAdminPassword'
      linuxConfiguration: {
        disablePasswordAuthentication: true
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: adminServerNIC.id
        }
      ]
    }
  }
}

resource webServerBackupSchedule 'Microsoft.Compute/virtualMachines/extensions@2022-09-01' = {
  name: 'webServerBackupSchedule'
    location: location
  dependsOn: [
    webServerVM
  ]
  properties: {
    publisher: 'Microsoft.Azure.RecoveryServices'
    type: 'BackupExtension'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    settings: {
      backupSchedule: {
        frequency: 'Daily'
        retentionCount: 7
      }
    }
    protectedSettings: {
      containerName: 'webServerBackups'
      storageAccountName: 'yourStorageAccountName'
      storageAccountSasToken: 'yourStorageAccountSasToken'
    }
  }
}

resource webServerInboundNSGRule 'Microsoft.Network/networkSecurityGroups/securityRules@2022-09-01' = {
  name: 'webServerInboundNSGRule'
  location: location
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: adminSourceIPRanges[0]
    destinationAddressPrefix: '*'
    access: 'Allow'
    direction: 'Inbound'
    priority: 100
  }
}

resource webServerNSG 'Microsoft.Network/networkSecurityGroups@2022-09-01' = {
  name: 'webServerNSG'
  location: location
  properties: {
    securityRules: [
      webServerInboundNSGRule
    ]
  }
}

resource webServerSubnetNSGAssociation 'Microsoft.Network/virtualNetworks/subnets/networkSecurityGroups@2022-09-01' = {
  name: 'webServerSubnetNSGAssociation'
  properties: {
    networkSecurityGroup: {
      id: webServerNSG.id
    }
  }
}

output adminServerPublicIP string = adminServerPublicIP.properties.ipAddress


output webServerPublicIP string = webServerPublicIP.properties.ipAddress
