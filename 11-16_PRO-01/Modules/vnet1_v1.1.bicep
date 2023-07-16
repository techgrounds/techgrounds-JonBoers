@description('Name of webserver Vnet & subnet')
param appVnetName string = 'app-prd-vnet'
param subnetName string = 'backendSubnet'
param sqlsubnetName string = 'mySqlSubnet'
param agsubnetname string = 'agsubnet'

// @description('Webserver Admin username')
// param webadmin_username string

// @description('Webserver Admin password')
// @secure()
// @minLength(6)
// param webadmin_password string

@description('Name of NSG webserver')
param name_nsg_webserver string = 'nsg_webserver'

@description('Name of NSG Sqlserver')
param name_mySql_server string = 'mySql_server'

@description('Name of NSG Application Gateway')
param name_nsg_AG string = 'nsg_AG'

@description('Location for all resources.')
param location string = resourceGroup().location

var availabilitySetName = 'AvSet'
var storageAccountType = 'Standard_LRS'
param storageAccountName string = uniqueString(resourceGroup().id)

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
// Contains 3 subnets, hosting the webserver VMSS, sql database and App Gateway.

resource virtualNetwork1 'Microsoft.Network/virtualNetworks@2021-05-01' = {
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
          addressPrefix: '10.10.10.0/26'
          networkSecurityGroup: {
            id: nsg_webserver.id
          }
        }
      }
      {
        name: sqlsubnetName
        properties: {
          addressPrefix: '10.10.10.64/26'
          networkSecurityGroup: {
            id: nsg_mySqlServer.id
          }
        }
      }
      {
        name: agsubnetname
        properties: {
          addressPrefix: '10.10.10.128/26'
          networkSecurityGroup: {
            id: nsg_AG.id
          }
        }
      }
    ]
  }
}

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
/*                                NSG mySqlServer                             */
/* -------------------------------------------------------------------------- */

resource nsg_mySqlServer 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: name_mySql_server
  location: location
  tags: {
    vnet: appVnetName
    location: location
  }
  properties: {
    securityRules: [      
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
      // Infrastructure ports - Allow incoming requests from the source as GatewayManager service tag and
      // any destination. The destination port range differs based on SKU and is required for communicating
      // the status of the Backend Health. (These ports are protected/locked down by Azure certificates. 
      // External entities can't initiate changes on those endpoints without appropriate certificates in place).
      // * V2: Ports 65200-65535
      // * V1: Ports 65503-65534
      // https://learn.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure

      {
        name: 'GatewayManager'
        properties: {
          protocol: 'TCP'
          sourceAddressPrefix: 'GatewayManager'
          sourcePortRange: '*' 
          destinationAddressPrefix: '*' 
          destinationPortRange: '65200-65535'
          access: 'Allow'
          priority: 1200
          direction: 'Inbound'
        }
      }        
    ]
  }
}

output vnet1Name string = virtualNetwork1.name
output vnet1ID string = virtualNetwork1.id
output vnet1Subnet1ID string = virtualNetwork1.properties.subnets[0].name
output vnet1mySqlSubnetID string = virtualNetwork1.properties.subnets[1].name
output vnet1AGSubnetID string = virtualNetwork1.properties.subnets[2].name
// output nsg_AGName string = nsg_AG.name

// output the storage account id

output storageAccountName string = storageAccount.name
output storageAccountBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob
