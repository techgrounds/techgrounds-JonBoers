@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

@description('Prefix to use for VM name')
param vmNamePrefix string = 'AdminServer'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Size of the virtual machines')
param virtualMachineSize string

/* -------------------------------------------------------------------------- */
/*                              imported param's                              */
/* -------------------------------------------------------------------------- */
param virtualMachineComputerName1 string
param osDiskType string
param osDiskDeleteOption string
param nicDeleteOption string

@secure()
param patchMode string
param enableHotpatching bool
param securityType string
param secureBoot bool
param vTPM bool
param virtualMachine1Zone string

var availabilitySetName = 'AvSetAdminVnet'
var storageAccountType = 'Standard_LRS'
var storageAccountName = uniqueString(resourceGroup().id)
var virtualNetworkName = 'management-prd-vnet'
var subnetName = 'AdminSubnet'
var networkInterfaceName = 'Adminnic'
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)

/* -------------------------------------------------------------------------- */
/*                               Storage Account                              */
/* -------------------------------------------------------------------------- */
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountType
  }
  kind: 'StorageV2'
}
/* -------------------------------------------------------------------------- */
/*                              Availability Set                              */
/* -------------------------------------------------------------------------- */
resource availabilitySet 'Microsoft.Compute/availabilitySets@2021-11-01' = {
  name: availabilitySetName
  location: location
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformUpdateDomainCount: 2
    platformFaultDomainCount: 2
  }
}
/* -------------------------------------------------------------------------- */
/*                              Vnet management-prd-vnet                      */
/* -------------------------------------------------------------------------- */
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.20.20.0/24'
        }
      }
    ]
  }
}
/* -------------------------------------------------------------------------- */
/*                                     NIC                                    */
/* -------------------------------------------------------------------------- */
resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetRef
          }
          
          
        }
      }
    ]
  }
  dependsOn: [
    virtualNetwork    
  ]
}

/* -------------------------------------------------------------------------- */
/*                                     VM                                     */
/* -------------------------------------------------------------------------- */
resource virtualMachine1 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: vmNamePrefix
  location: location
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'fromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
        deleteOption: osDiskDeleteOption
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
          properties: {
            deleteOption: nicDeleteOption
          }
        }
      ]
    }
    osProfile: {
      computerName: virtualMachineComputerName1
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
        provisionVMAgent: true
        patchSettings: {
          enableHotpatching: enableHotpatching
          patchMode: patchMode
        }
      }
    }
    licenseType: 'Windows_Server'
    securityProfile: {
      securityType: securityType
      uefiSettings: {
        secureBootEnabled: secureBoot
        vTpmEnabled: vTPM
      }
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
  zones: [
    virtualMachine1Zone
  ]
}