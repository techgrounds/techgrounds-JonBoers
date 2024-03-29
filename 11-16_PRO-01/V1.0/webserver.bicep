//Imported parameters
@description('The environment name. "dev" and "prod" are valid inputs.')
@allowed([
  'dev'
  'prod'
])
param envName string = 'dev'

@description('The Azure Region into which the resources are deployed.')
param location string = resourceGroup().location

@secure()
@description('The administrator username.')
param adminUsername string

@secure()
@description('The administrator password.')
param adminPassword string

param Vnet1Name string
param vnet1Subnet1Identity string
param diskEncryptionSetName string
// param storageAccountName string
///////

//Parameters for the VMSS
@description('The name of the webserver VM scaleset.')
param webServerName string = '${take(envName, 3)}${take(location, 6)}websv${take(uniqueString(resourceGroup().id), 4)}'

@description('The SKU size for the VMSS.')
param webServerSku string = envName == 'dev' ? 'Standard_B1s' : 'Standard_B2s'

@description('When true this limits the scale set to a single placement group, of max size 100 virtual machines. NOTE: If singlePlacementGroup is true, it may be modified to false. However, if singlePlacementGroup is false, it may not be modified to true.')
param singlePlacementGroup bool = true
//////

//variables for VMSS
var vmScaleSetName = toLower(substring('vmss${uniqueString(resourceGroup().id)}', 0, 9))
var longvmScaleSet = toLower(webServerName)
var instanceCount = 1
var vmssId = webServer.id
var platformFaultDomainCount = 1
var imageReference = {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
}

//variables for other resources
var publicIPAddressName = '${vmScaleSetName}pip'
var publicIPAddressID = webServerPublicIP.id
var loadBalancerName = '${vmScaleSetName}lb'
var lbProbeID = resourceId('Microsoft.Network/loadBalancers/probes', loadBalancerName, 'tcpProbe')
var natPoolName = '${vmScaleSetName}natpool'
var bePoolName = '${vmScaleSetName}bepool'
var lbPoolID = resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancerName, bePoolName)
var natStartPort = 50000
var natEndPort = 50119
var natBackendPort = 3389
var nicName = '${vmScaleSetName}nic'
var ipConfigName = '${vmScaleSetName}ipconfig'
var frontEndIPConfigID = resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', loadBalancerName, 'loadBalancerFrontEnd')
var publicIpSku = 'Standard'
var autoScaleResourceName = '${webServerName}AutoScale'
var autoScaleDefault = '1'
var autoScaleMin = '1'
var autoScaleMax = '3'
var durationTimeWindow = 10
var predictiveAutoscaleMode = 'ForecastOnly'
var scaleOutCPUPercentageThreshold = 75
var scaleInCPUPercentageThreshold = 25
var scaleOutInterval = '1'
var scaleInInterval = '1'
// var webServerScriptName = '${vmScaleSetName}Script'
var launchScript = 'IyEvYmluL2Jhc2gKc3VkbyBzdQphcHQgdXBkYXRlCmFwdCBpbnN0YWxsIGFwYWNoZTIgLXkKdWZ3IGFsbG93ICdBcGFjaGUnCnN5c3RlbWN0bCBlbmFibGUgYXBhY2hlMgpzeXN0ZW1jdGwgcmVzdGFydCBhcGFjaGUy'
///////

//needed for V1.1
// resource diskEncryptionSet 'Microsoft.Compute/diskEncryptionSets@2022-07-02' existing = { 
//   name: diskEncryptionSetName
// }

/* -------------------------------------------------------------------------- */
/*           A load balancer connected to the vmss with a public IP.          */
/* -------------------------------------------------------------------------- */
resource loadBalancer 'Microsoft.Network/loadBalancers@2022-11-01' = {
  name: loadBalancerName
  location: location
  sku: {
    name: 'Standard'
  }
  tags: {
    Environment: envName
    Location: location
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: 'LoadBalancerFrontEnd'
        properties: {
          publicIPAddress: {
            id: publicIPAddressID
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: bePoolName
      }
    ]
    inboundNatPools: [
      {
        name: natPoolName
        properties: {
          frontendIPConfiguration: {
            id: frontEndIPConfigID
          }
          protocol: 'Tcp'
          frontendPortRangeStart: natStartPort
          frontendPortRangeEnd: natEndPort
          backendPort: natBackendPort
        }
      }
    ]
    loadBalancingRules: [
      {
        name: 'LBRule'
        properties: {
          frontendIPConfiguration: {
            id: frontEndIPConfigID
          }
          backendAddressPool: {
            id: lbPoolID
          }
          protocol: 'Tcp'
          frontendPort: 80
          backendPort: 80
          enableFloatingIP: false
          idleTimeoutInMinutes: 5
          probe: {
            id: lbProbeID
          }
        }
      }
    ]
    probes: [
      {
        name: 'tcpProbe'
        properties: {
          protocol: 'Tcp'
          port: 80
          intervalInSeconds: 5
          numberOfProbes: 2
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                                    VMSS                                    */
/* -------------------------------------------------------------------------- */
resource webServer 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: webServerName
  location: location
  tags: {
    Environment: envName
    Location: location
  }
  sku: {
    capacity: int(instanceCount)
    name: webServerSku
    tier: 'Standard'
  }
  properties: {
    overprovision: true
    upgradePolicy: {
      mode: 'Manual'
    }
    singlePlacementGroup: singlePlacementGroup
    platformFaultDomainCount: platformFaultDomainCount
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
          managedDisk: {
            storageAccountType: 'StandardSSD_LRS'
            diskEncryptionSet: {
              id: diskEncryptionSet.id
            }
          }
        }
        imageReference: imageReference
      }
      osProfile: {
        computerNamePrefix: vmScaleSetName
        adminUsername: adminUsername
        adminPassword: adminPassword
        customData: launchScript
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: nicName
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: ipConfigName
                  properties: {
                    subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets', Vnet1Name, vnet1Subnet1Identity)
                    }
                    loadBalancerBackendAddressPools: [
                      {
                        id: lbPoolID
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
  dependsOn: [
    loadBalancer
  ]
}

/* -------------------------------------------------------------------------- */
/*                           Public IP load balancer                          */
/* -------------------------------------------------------------------------- */
resource webServerPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: publicIpSku
  }
  tags: {
    Environment: envName
    Location: location
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: longvmScaleSet
    }
  }
}

/* -------------------------------------------------------------------------- */
/*                      Autoscaling resource for the vmss                     */
/* -------------------------------------------------------------------------- */
resource autoScaleResource 'Microsoft.Insights/autoscalesettings@2022-10-01' = {
  name: autoScaleResourceName
  location: location
  properties: {
    name: autoScaleResourceName
    targetResourceUri: vmssId
    enabled: true
    profiles: [
      {
        name: 'Profile1'
        capacity: {
          minimum: autoScaleMin
          maximum: autoScaleMax
          default: autoScaleDefault
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricNamespace: ''
              metricResourceUri: vmssId
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT${durationTimeWindow}M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: scaleOutCPUPercentageThreshold
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: scaleOutInterval
              cooldown: 'PT1M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricNamespace: ''
              metricResourceUri: vmssId
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: scaleInCPUPercentageThreshold
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: scaleInInterval
              cooldown: 'PT1M'
            }
          }
        ]
      }
    ]
    predictiveAutoscalePolicy: {
      scaleMode: predictiveAutoscaleMode
      scaleLookAheadTime: 'PT14M'
    }
  }
}

// resource webServerScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
//   name: webServerScriptName
//   location: location
//   kind: 'AzureCLI'
//   identity: {
//     type: 'SystemAssigned'
//   }
//   properties: {
//     azCliVersion: '2.0.80'
//     retentionInterval: 'P1D'
//     cleanupPreference: 'Always'
//     primaryScriptUri: 'https://github.com/techgrounds/techgrounds-laminated-denim/blob/main/10_PRO_1/project/scripts/apache.sh'
//     storageAccountSettings: {
//       storageAccountName: storageAccount.name
//       storageAccountKey: storageAccount.listKeys('2022-09-01').keys[0].value
//     }
//   }
//   dependsOn: [
//     storageAccount
//     webServer
//   ]
// }

// resource extension 'Microsoft.Compute/virtualMachineScaleSets/extensions@2023-03-01' = {
//   parent: webServer
//   name: 'install_apache'
//   properties: {
//     publisher: 'Microsoft.Azure.Extensions'
//     type: 'CustomScript'
//     typeHandlerVersion: '2.1'
//     autoUpgradeMinorVersion: true
//     settings: {
//       skipDos2Unix: false
//       fileUris: [

//       'https://github.com/techgrounds/techgrounds-laminated-denim/blob/main/10_PRO_1/project/scripts/apache.sh'
//       ]
//     }
//     protectedSettings: {
//       commandToExecute: 'sh apache.sh'
//     }
//   }
// }

//Output webserver name
output webServerName string = webServer.name
output webServerID string = webServer.id
