@description('Admin username')
param webadmin_username string

@description('Admin password')
@secure()
param webadmin_password string

@description('Prefix to use for VM names')
param vmNamePrefix string = 'Webserver'

@description('Name of webserver Vnet & subnet')
param appVnetName string = 'app-prd-vnet'
param subnetName string = 'backendSubnet'
param agsubnetname string = 'agsubnet'

@description('Name of public IP Webserver')
param name_pubip_webserver string = '${appVnetName}-publicIP'

@description('Name of NSG webserver')
param name_nsg_webserver string = 'nsg_webserver'

@description('Name of NSG Application Gateway')
param name_nsg_AG string = 'nsg_AG'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Size of the virtual machines')
param vmSize string = 'Standard_D2s_v3'

@description('declare apache script')
var apache_script = loadFileAsBase64('install-apache.sh')
var availabilitySetName = 'AvSet'
var storageAccountType = 'Standard_LRS'
var storageAccountName = uniqueString(resourceGroup().id)
var loadBalancerName = 'ilb'
var networkInterfaceName = 'nic'
var subnetRef = resourceId('Microsoft.Network/vnet1s/subnets', appVnetName, subnetName)

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
/*                              Vnet app-prd-vnet                             */
/* -------------------------------------------------------------------------- */
resource vnet1 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: appVnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.10.10.0/25'
          networkSecurityGroup: {
            id: nsg_webserver.id
          }
        }
      }
      {
        name: agsubnetname
        properties: {
          addressPrefix: '10.10.10.128/27'
          networkSecurityGroup: {
            id: nsg_AG.id
          }
        }
      }
    ]
  }
}

// /* -------------------------------------------------------------------------- */
// /*                             Public IP Webserver                            */
// /* -------------------------------------------------------------------------- */

// resource pub_ip_webserver 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
//   name: name_pubip_webserver
//   location: location
//   tags: {
//     vnet: appVnetName
//     location: location
//   }
//   sku: {
//     name: 'standard'    
//   }  
//   properties: {
//     publicIPAllocationMethod: 'Static'
//   }
// }

/* -------------------------------------------------------------------------- */
/*                                NSG Webserver                               */
/* -------------------------------------------------------------------------- */

resource nsg_webserver 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: name_nsg_webserver
  location: location
  tags: {
    vnet: appVnetName
    location: location
  }
  properties: {
    securityRules: [
      { name: 'https'
        properties: {
          access: 'Allow' 
          direction: 'Inbound' 
          priority: 1000
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '443'
          destinationAddressPrefix: '*'
        }
      } 
      {
        name: 'http'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority:1100
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '80'
          destinationAddressPrefix: '*'        
        }
      }
      
      {
        name: 'ssh_access_adminServer'
        properties: {
          protocol: 'TCP'
          sourceAddressPrefix: '10.20.20.10/32' //Private IP address nic adminServer (vnet2)
          sourcePortRange: '*' 
          destinationAddressPrefix: '*' 
          destinationPortRange: '22'
          access: 'Allow'
          priority: 1200
          direction: 'Inbound'
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                                   NSG AG                                   */
/* -------------------------------------------------------------------------- */

resource nsg_AG 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: name_nsg_AG
  location: location
  tags: {
    vnet: appVnetName
    location: location
  }
  properties: {
    securityRules: [
      { name: 'https'
        properties: {
          access: 'Allow' 
          direction: 'Inbound' 
          priority: 1000
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '443'
          destinationAddressPrefix: '*'
        }
      } 
      {
        name: 'http'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority:1100
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '80'
          destinationAddressPrefix: '*'        
        }
      }      
    ]
  }
}

// /* -------------------------------------------------------------------------- */
// /*                                     NIC                                    */
// /* -------------------------------------------------------------------------- */
// resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = [for i in range(0, numberOfInstances): {
//   name: '${networkInterfaceName}${i}'
//   location: location
//   properties: {
//     ipConfigurations: [
//       {
//         name: 'ipconfig1'
//         properties: {
//           privateIPAllocationMethod: 'Dynamic'          
//           subnet: {
//             id: subnetRef
//           }
//           loadBalancerBackendAddressPools: [
//             {
//               id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancerName, 'BackendPool1')
//             }
//           ]
//         }
//       }
//     ]
//   }
//   dependsOn: [
//     vnet1
//     // loadBalancer
//   ]
// }]
// /* -------------------------------------------------------------------------- */
// /*                                Loadbalancer                                */
// /* -------------------------------------------------------------------------- */
// resource loadBalancer 'Microsoft.Network/loadBalancers@2021-05-01' = {
//   name: loadBalancerName
//   location: location
//   sku: {
//     name: 'Standard'
//   }
//   properties: {
//     frontendIPConfigurations: [
//       {
//         properties: {
//           publicIPAddress: { //koppeling met publiek-ip
//             id: pub_ip_webserver.id
//           }          
//           // privateIPAddress: '10.10.10.10'
//           // privateIPAllocationMethod: 'Static'
//         }
//         name: 'LoadBalancerFrontend'
//       }
//     ]
//     backendAddressPools: [
//       {
//         name: 'BackendPool1'
//       }
//     ]
//     loadBalancingRules: [
//       {
//         properties: {
//           frontendIPConfiguration: {
//             id: resourceId('Microsoft.Network/loadBalancers/frontendIpConfigurations', loadBalancerName, 'LoadBalancerFrontend')
//           }
//           backendAddressPool: {
//             id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancerName, 'BackendPool1')
//           }
//           probe: {
//             id: resourceId('Microsoft.Network/loadBalancers/probes', loadBalancerName, 'lbprobe')
//           }
//           protocol: 'Tcp'
//           frontendPort: 80
//           backendPort: 80
//           idleTimeoutInMinutes: 15
//         }
//         name: 'lbrule'
//       }
//     ]
//     probes: [
//       {
//         properties: {
//           protocol: 'Tcp'
//           port: 80
//           intervalInSeconds: 15
//           numberOfProbes: 2
//         }
//         name: 'lbprobe'
//       }
//     ]
//   }
//   dependsOn: [
//     vnet1
//   ]
// }
// /* -------------------------------------------------------------------------- */
// /*                                    VM's                                    */


// /* -------------------------------------------------------------------------- */
// resource vm 'Microsoft.Compute/virtualMachines@2022-03-01' = [for i in range(0, numberOfInstances): {
//   name: '${vmNamePrefix}${i}'
//   location: location
//   properties: {
//     userData: apache_script
//     availabilitySet: {
//       id: availabilitySet.id
//     }
//     hardwareProfile: {
//       vmSize: vmSize
//     }
//     osProfile: {
//       computerName: '${vmNamePrefix}${i}'
//       adminUsername: webadmin_username
//       adminPassword: webadmin_password
//     }
//     storageProfile: {
//       imageReference: {
//         publisher: 'canonical'
//         offer: '0001-com-ubuntu-server-jammy'
//         sku: '22_04-lts-gen2'
//         version: 'latest'
//       }
//       osDisk: {
//         createOption: 'FromImage'
//       }
//     }
//     networkProfile: {
//       networkInterfaces: [
//         {
//           id: networkInterface[i].id
//         }
//       ]
//     }
//     diagnosticsProfile: {
//       bootDiagnostics: {
//         enabled: true
//         storageUri: storageAccount.properties.primaryEndpoints.blob
//       }
//     }
//   }
// }]

output vnet1Name string = vnet1.name
output vnet1Id string = vnet1.name
output vnet1Subnet1ID string = vnet1.properties.subnets[0].name

//output the storage account id
output storageAccountName string = storageAccount.name
output storageAccountBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob
