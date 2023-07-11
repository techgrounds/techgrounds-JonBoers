targetScope = 'subscription'

@description('The environment name. "dev" and "prod" are valid inputs.')
@allowed([
  'dev'
  'prod'
])
param envName string = 'dev'

@description('Webserver Admin username')
param webadmin_username string = 'MobyJon'

@description('Webserver Admin password')
@secure()
@minLength(6)
param webadmin_password string

@description('ManagementServer username')
param ManadminUsername string = 'MobyWan'

@description('Management server password')
@secure()
@minLength(6)
param ManadminPassword string

@description('Declare allowed IP range via SSH and RDP.')
param allowedIpRange array = ['145.53.122.18']

@description('Make general resource group for deployment in certain region')
param resourceGroupName string = 'testrgV1.1'
param location string = deployment().location // locate resources at location declared with the deployment command
resource rootgroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

@description('Param & Var for sqlDB')
param instanceNumber string = '001'
param applicationName string = 'mySQL'

var defaultTags = {
  environment: envName
  application: applicationName
}

@description('deploy vnet1') 

module appVnetName 'Modules/vnet1_v1.1.bicep' = {
  name: 'webserverVnet'
  scope: rootgroup
  params: {
    // webadmin_username: webadmin_username
    // webadmin_password: webadmin_password
    location: location
  }
}

@description('deploy vnet2') 

module ManagementVnetName 'Modules/vnet2_v1.1.bicep' = {
  name: 'adminvnet'
  scope: rootgroup
  params: {
    allowedIpRange: allowedIpRange
    ManadminPassword: ManadminPassword
    ManadminUsername: ManadminUsername
    location: location
    patchMode: 'manual' //will be done by company admins to avoid unscheduled downtime of vm
    storageAccountBlobEndpoint: appVnetName.outputs.storageAccountBlobEndpoint 
  }

}

@description('deploy VMSS webserver')
module webServer 'modules/webserver.bicep' = {
  name: 'webServer-${location}'
  scope: rootgroup
  params: {
    envName: envName
    location: location
    adminUsername: webadmin_username
    adminPassword: webadmin_password
    Vnet1Name : appVnetName.outputs.vnet1Name
    vnet1Subnet1Identity: appVnetName.outputs.vnet1Subnet1ID
    // diskEncryptionSetName: keyvault.outputs.diskEncryptionSetName
    // storageAccountName: storage.outputs.storageAccountName
    // StorageAccBlobEndpoint: storage.outputs.storageAccountBlobEndpoint
  }
  
}

@description('Deploy network peering module')
// Deploy network peering module
module peering 'Modules/peering.bicep' = {
  name: 'peering_deployment'
  scope: rootgroup
  params: {
    vnet1Name : appVnetName.outputs.vnet1Name
    vnet2Name : ManagementVnetName.outputs.vnet2Name
    vnet1Id : appVnetName.outputs.vnet1ID
    vnet2Id : ManagementVnetName.outputs.vnet2Id

    }
  }

  module sqlDb 'modules/mysql.bicep' = {
    name: 'sqldatabase'
    scope: resourceGroup(rootgroup.name)
    params: {
      location: location
      applicationName: applicationName
      environment: envName
      tags: defaultTags
      instanceNumber: instanceNumber
    }
  }
