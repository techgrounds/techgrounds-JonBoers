@description('The name of you Virtual Machine.')
param vmName string = 'LinuxVMformySQL'

@description('Username for the Virtual Machine.')
param mySQLAdminUsername string = 'mySQLadmin'

@description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'

@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
@secure()
param adminPasswordOrKey string = newGuid()

param Vnet1Name string
param vnet1mySqlSubnetIdentity string

@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
param dnsLabelPrefix string = toLower('${vmName}-${uniqueString(resourceGroup().id)}')

@description('The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version.')
@allowed([
  'Ubuntu-1804'
  'Ubuntu-2004'
  'Ubuntu-2204'
])
param ubuntuOSVersion string = 'Ubuntu-2204'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The size of the VM')
param vmSize string = 'Standard_D2s_v3'

// @description('Name of the VNET')
// param virtualNetworkName string = 'vNet'

// @description('Name of the subnet in the virtual network')
// param subnetName string = 'Subnet'

// @description('Name of the Network Security Group')
// param networkSecurityGroupName string = 'SecGroupNet'

@description('Security Type of the Virtual Machine.')
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'TrustedLaunch'

var launchmySQLscript = 'IyEvYmluL2Jhc2gKCiMgU2V0IE15U1FMIHJvb3QgcGFzc3dvcmQgZnJvbSB0aGUgcGFyYW1ldGVyCm15c3FsUGFzc3dvcmQ9Im15REB0QGJAc2UiCgojIFVwZGF0ZSBwYWNrYWdlIGxpc3RzIGFuZCB1cGdyYWRlIHBhY2thZ2VzCnN1ZG8gYXB0IHVwZGF0ZQpzdWRvIGFwdCB1cGdyYWRlIC15CgojIEluc3RhbGwgTXlTUUwgU2VydmVyCmlmIHN1ZG8gYXB0IGluc3RhbGwgLXkgbXlzcWwtc2VydmVyOyB0aGVuCiAgIyBTZXQgTXlTUUwgcm9vdCBwYXNzd29yZAogIHN1ZG8gbXlzcWwgLWUgIkFMVEVSIFVTRVIgJ3Jvb3QnQCdsb2NhbGhvc3QnIElERU5USUZJRUQgV0lUSCBteXNxbF9uYXRpdmVfcGFzc3dvcmQgQlkgJyRteXNxbFBhc3N3b3JkJzsgRkxVU0ggUFJJVklMRUdFUzsiCiAgZWNobyAiTXlTUUwgU2VydmVyIGluc3RhbGxlZCBhbmQgcm9vdCBwYXNzd29yZCBzZXQgc3VjY2Vzc2Z1bGx5LiIKZWxzZQogIGVjaG8gIkZhaWxlZCB0byBpbnN0YWxsIE15U1FMIFNlcnZlci4iCiAgZXhpdCAxCmZpCgojIENoZWNrIHRoZSBNeVNRTCBzZXJ2aWNlIHN0YXR1cwpzdWRvIHNlcnZpY2UgbXlzcWwgc3RhdHVzCg=='

var imageReference = {
  'Ubuntu-1804': {
    publisher: 'Canonical'
    offer: 'UbuntuServer'
    sku: '18_04-lts-gen2'
    version: 'latest'
  }
  'Ubuntu-2004': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-focal'
    sku: '20_04-lts-gen2'
    version: 'latest'
  }
  'Ubuntu-2204': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
  }
}
var publicIPAddressName = '${vmName}PublicIP'
var SqlNicName = '${vmName}NetInt'
var osDiskType = 'Standard_LRS'
// var ipConfigName = '${vmName}ipconfig'
// var subnet = resourceId('Microsoft.Network/virtualNetworks/subnets', Vnet1Name, vnet1mySqlSubnetIdentity)
// var subnetAddressPrefix = '10.10.10.0/25'
// var addressPrefix = '10.1.0.0/16'
var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${mySQLAdminUsername}/.ssh/authorized_keys'
        keyData: adminPasswordOrKey
      }
    ]
  }
}
var securityProfileJson = {
  uefiSettings: {
    secureBootEnabled: true
    vTpmEnabled: true
  }
  securityType: securityType
}
// var extensionName = 'GuestAttestation'
// var extensionPublisher = 'Microsoft.Azure.Security.LinuxAttestation'
// var extensionVersion = '1.0'
// var maaTenantName = 'GuestAttestation'
// var maaEndpoint = substring('emptystring', 0, 0)

resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: SqlNicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', Vnet1Name, vnet1mySqlSubnetIdentity)
            // id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
    // networkSecurityGroup: {
    //   id: networkSecurityGroup.id
    // }
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    publicIPAddressVersion: 'IPv4'
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
    idleTimeoutInMinutes: 4
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: vmName
  location: location
  properties: {
      hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: imageReference[ubuntuOSVersion]
    }
    networkProfile: {
      // networkApiVersion: '2021-05-01'
      networkInterfaces: [        
        {
          id: networkInterface.id
        }        
      ]
      
    }
    osProfile: {
      computerName: vmName
      adminUsername: mySQLAdminUsername
      adminPassword: adminPasswordOrKey
      customData: launchmySQLscript
      linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
    }
    securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)
  }
}

// resource vmExtension 'Microsoft.Compute/virtualMachines/extensions@2022-03-01' = if ((securityType == 'TrustedLaunch') && ((securityProfileJson.uefiSettings.secureBootEnabled == true) && (securityProfileJson.uefiSettings.vTpmEnabled == true))) {
//   parent: vm
//   name: extensionName
//   location: location
//   properties: {
//     publisher: extensionPublisher
//     type: extensionName
//     typeHandlerVersion: extensionVersion
//     autoUpgradeMinorVersion: true
//     enableAutomaticUpgrade: true
//     settings: {
//       AttestationConfig: {
//         MaaSettings: {
//           maaEndpoint: maaEndpoint
//           maaTenantName: maaTenantName
//         }
//       }
//     }
//   }
// }

output adminUsername string = mySQLAdminUsername
// output hostname string = publicIPAddress.properties.dnsSettings.fqdn
// output sshCommand string = 'ssh ${mySQLAdminUsername}@${publicIPAddress.properties.dnsSettings.fqdn}'
