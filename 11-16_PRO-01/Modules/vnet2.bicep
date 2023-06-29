@description('Admin username')
param ManadminUsername string

@description('Admin password')
@secure()
param ManadminPassword string

@description('Prefix to use for VM name')
param vmNamePrefix string = 'AdminServer'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Size of the virtual machines')
param virtualMachineSize string = 'Standard_D2ds_v4'
param nicDeleteOption string = 'delete'
param osDiskDeleteOption string = 'delete'
param osDiskType string = 'Standard_LRS'

@description('Name of manserver Vnet')
param ManagementVnetName string = 'management-prd-vnet'

@description('Name of public IP Manserver')
param name_pubip_manserver string = '${ManagementVnetName}-publicIP'

@description('Name of NSG manserver')
param name_nsg_manserver string = 'nsg_manserver'

@description('Declare allowed IP range via SSH and RDP.')
param allowedIpRange array

@secure() //settings specified in main.bicep
param patchMode string
// param enableHotpatching bool
// param securityType string
// param secureBoot bool
// param vTPM bool

var availabilitySetName = 'AvSetAdminVnet'

var subnetName = 'AdminSubnet'
var networkInterfaceName = 'Adminnic'
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', ManagementVnetName, subnetName)

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
resource virtualNetwork2 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: ManagementVnetName
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
          networkSecurityGroup: {
            id: nsg_manserver.id
          }
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
        name: 'Manserveripconfig1'
        properties: {
          privateIPAddress: '10.20.20.10'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Static'          
          publicIPAddress: { //koppeling met publiek-ip
            id: pub_ip_manserver.id
          }
          subnet: {
            id: subnetRef
          }         
        }
      }
    ]
  }
  dependsOn: [
    virtualNetwork2    
  ]
}

/* -------------------------------------------------------------------------- */
/*                                     VM                                     */
/* -------------------------------------------------------------------------- */
resource virtualMachine1 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: vmNamePrefix
  location: location
  properties: {
    availabilitySet: {
      id: availabilitySet.id
    }
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
      computerName: vmNamePrefix
      adminUsername: ManadminUsername
      adminPassword: ManadminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: false
        provisionVMAgent: true
        patchSettings: {          
          patchMode: patchMode
        }
      }
    }
    licenseType: 'Windows_Server'
    securityProfile: {
      // securityType: securityType
      // uefiSettings: {
      //   secureBootEnabled: secureBoot
      //   vTpmEnabled: vTPM
      // }
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

/* -------------------------------------------------------------------------- */
/*                             Public IP Management server                            */
/* -------------------------------------------------------------------------- */

resource pub_ip_manserver 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: name_pubip_manserver
  location: location
  tags: {
    vnet: ManagementVnetName
    location: location
  }
  sku: {
    name: 'standard'    
  }  
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

/* -------------------------------------------------------------------------- */
/*                            NSG Management server                           */
/* -------------------------------------------------------------------------- */

resource nsg_manserver 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: name_nsg_manserver
  location: location
  tags: {
    vnet: ManagementVnetName
    location: location
  }
  properties: {
    securityRules: [
      {
        name: 'ssh'
        properties: {
          protocol: 'TCP'
          sourceAddressPrefix: '${allowedIpRange[0]}/32'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '22'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
            }
          }
            {
            name: 'RDP'
            properties: {
              protocol: 'TCP'
              sourceAddressPrefix: '${allowedIpRange[0]}/32'
              destinationAddressPrefix: '*'
              sourcePortRange: '*'
              destinationPortRange: '3389'
              access: 'Allow'
              priority: 200
              direction: 'Inbound'
                }
              }
        ]
      }
  
}

output vnet2Name string = virtualNetwork2.name
output vnet2Id string = virtualNetwork2.id

