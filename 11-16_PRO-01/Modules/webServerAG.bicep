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

@secure()
@description('The password for the SSL certificate.')
param sslPassword string 

param Vnet1Name string
param vnet1Subnet1Identity string

// param nsg_AGName string

// param diskEncryptionSetName string
// param storageAccountName string
///////

//Parameters for the VMSS
@description('The name of the webserver VM scaleset.')
param webServerName string = '${take(envName, 3)}${take(location, 6)}websv${take(uniqueString(resourceGroup().id), 4)}'

@description('The SKU size for the VMSS.')
param webServerSku string = envName == 'dev' ? 'Standard_B1s' : 'Standard_B2s'

// @description('The base URI where artifacts required by this template are located. For example, if stored on a public GitHub repo, you\'d use the following URI: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/201-vmss-windows-webapp-dsc-autoscale/.')
// param _artifactsLocation string = deployment().properties.templateLink.uri

@description('When true this limits the scale set to a single placement group, of max size 100 virtual machines. NOTE: If singlePlacementGroup is true, it may be modified to false. However, if singlePlacementGroup is false, it may not be modified to true.')
param singlePlacementGroup bool = true
//////

/* -------------------------------------------------------------------------- */
/*                             variables for VMSS                             */
/* -------------------------------------------------------------------------- */
var vmScaleSetName = toLower(substring('vmss${uniqueString(resourceGroup().id)}', 0, 9))
var longvmScaleSet = toLower(webServerName)
var instanceCount = 1
var vmssId = webServer.id
var platformFaultDomainCount = 1
var launchScript = 'IyEvYmluL2Jhc2gKc3VkbyBzdQphcHQgdXBkYXRlCmFwdCBpbnN0YWxsIGFwYWNoZTIgLXkKdWZ3IGFsbG93ICdBcGFjaGUnCnN5c3RlbWN0bCBlbmFibGUgYXBhY2hlMgpzeXN0ZW1jdGwgcmVzdGFydCBhcGFjaGUy'
var imageReference = {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
}

/* -------------------------------------------------------------------------- */
/*                        variables for other resources                       */
/* -------------------------------------------------------------------------- */
var appGatewayName = '${vmScaleSetName}gateway'
var bePoolID = resourceId('Microsoft.Network/applicationGateways/backendAddressPools', appGatewayName, bePoolName)
var bePoolName = '${vmScaleSetName}bepool'
var lbPoolID = resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancerName, bePoolName)
var publicIPAddressName = '${vmScaleSetName}pip'
var publicIPAddressID = webServerPublicIP.id
var loadBalancerName = '${vmScaleSetName}lb'
var lbProbeID = resourceId('Microsoft.Network/loadBalancers/probes', loadBalancerName, 'tcpProbe')
var natPoolName = '${vmScaleSetName}natpool'
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

/* -------------------------------------------------------------------------- */
/*                           Self signed certificate                          */
/* -------------------------------------------------------------------------- */

param base64EncodedCert string = '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'

// resource diskEncryptionSet 'Microsoft.Compute/diskEncryptionSets@2022-07-02' existing = {
//   name: diskEncryptionSetName
// }

resource virtualNetwork1 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: Vnet1Name
}

// resource nsg_AG 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
//   name: nsg_AGName
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
/*   Application Gateway                                                      */
/* -------------------------------------------------------------------------- */

resource appGateway 'Microsoft.Network/applicationGateways@2022-11-01' = {
  name: appGatewayName
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    sslCertificates: [
      {
        name: 'appGatewaySslCert'
        properties: {
          data: base64EncodedCert
          password: sslPassword
        }
      }
    ]
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: virtualNetwork1.properties.subnets[2].id
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGatewayFrontendIP'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: webServerPublicIP.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'appGatewayHTTPFrontendPort'
        properties: {
          port: 80
        }
      }
      {
        name: 'appGatewayHTTPSFrontendPort'
        properties: {
          port: 443
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGatewayHTTPListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGatewayName, 'appGatewayFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGatewayName, 'appGatewayHTTPFrontendPort')
          }
          protocol: 'Http'
          requireServerNameIndication: false
        }
      }
      {
        name: 'appGatewayHTTPSListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGatewayName, 'appGatewayFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGatewayName, 'appGatewayHTTPSFrontendPort')
          }
          protocol: 'Https'
          requireServerNameIndication: false
          sslCertificate: {
            id: resourceId('Microsoft.Network/applicationGateways/sslCertificates', appGatewayName, 'appGatewaySSLCert')
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: bePoolName
        }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 30
        }
      }
    ]
    redirectConfigurations: [
      {
        name: 'appGatewayRedirectConfig'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGatewayName, 'appGatewayHttpsListener')
          }
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'routingRuleHTTP'
        properties: {
          ruleType: 'Basic'
          priority: 1
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGatewayName, 'appGatewayHttpListener')
          }
          redirectConfiguration: {
              id: resourceId('Microsoft.Network/applicationGateways/redirectConfigurations', appGatewayName, 'appGatewayRedirectConfig')
            }
          }
        }
      {
        name: 'routingRuleHTTPS'
        properties: {
          ruleType: 'Basic'
          priority: 10
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGatewayName, 'appGatewayHttpsListener')
          }
          backendAddressPool: {
            id: bePoolID
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', appGatewayName, 'appGatewayBackendHttpSettings')
          }
        }
      }
    ]
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 1
      maxCapacity: 2
    }
  }
  dependsOn: [
    virtualNetwork1
    // nsg_AG
  ]
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
            // diskEncryptionSet: {
            //   id: diskEncryptionSet.id
            // }
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

//Output webserver name
output webServerName string = webServer.name
output webServerID string = webServer.id
