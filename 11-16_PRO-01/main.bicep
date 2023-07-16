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
param webadmin_password string = newGuid()

@description('ManagementServer username')
param ManadminUsername string = 'MobyWan'

@description('Management server password')
@secure()
@minLength(6)
param ManadminPassword string = newGuid()

@secure()
@description('The password for the SSL certificate.')
param sslPassword string

// @description('Database administrator login name')
// @minLength(1)
// param dbAdminLogin string = 'dbAdmin'

@description('Database administrator password')
@minLength(6)
@secure()
param dbAdminLoginPassword string = newGuid()

// param serverName string = 'serverName'

@description('Declare allowed IP range via SSH and RDP.')
param allowedIpRange array = ['145.53.122.18']

@description('Make general resource group for deployment in certain region')
param resourceGroupName string = 'testrgV1.1'
param location string = deployment().location // locate resources at location declared with the deployment command
resource rootgroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

/* -------------------------------------------------------------------------- */
/*                                Vnet1 module                                */
/* -------------------------------------------------------------------------- */

module appVnetName 'Modules/vnet1_v1.1.bicep' = {
  name: 'webserverVnet'
  scope: rootgroup
  params: {
    location: location
  }
}

/* -------------------------------------------------------------------------- */
/*                                Vnet2 module                                */
/* -------------------------------------------------------------------------- */

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
/* -------------------------------------------------------------------------- */
/*                               Keyvault module                              */
/* -------------------------------------------------------------------------- */
@description('Deploy keyvault and encryption module')   // deploys with encrypted diskset - need to fix passwords at other time
// Deploy Keyvault & encryption module
module keyvault 'Modules/keyvault.bicep' = {
  scope: rootgroup
  name: 'keyvault_deployment'
  params: {
    location: location
    envName: envName
  }
}

/* -------------------------------------------------------------------------- */
/*                Deploy VMSS webserver and application gateway               */
/* -------------------------------------------------------------------------- */
module webServer 'modules/webserverAG.bicep' = {
  name: 'webServer-${location}'
  scope: rootgroup
  params: {
    envName: envName
    location: location
    adminUsername: webadmin_username
    adminPassword: webadmin_password
    sslPassword: sslPassword
    // nsg_AGName: appVnetName.outputs.nsg_AGName
    Vnet1Name : appVnetName.outputs.vnet1Name
    vnet1Subnet1Identity: appVnetName.outputs.vnet1Subnet1ID
    // diskEncryptionSetName: keyvault.outputs.diskEncryptionSetName
    // storageAccountName: storage.outputs.storageAccountName
    // StorageAccBlobEndpoint: storage.outputs.storageAccountBlobEndpoint
  }
  
}

@description('deploy mySQL server')
module SQLServer 'modules/mySQLvm.bicep' = {
  name: 'SQLServer-${location}'
  scope: rootgroup
  params: {
    // envName: envName
    adminPasswordOrKey : dbAdminLoginPassword
    location: location
    Vnet1Name : appVnetName.outputs.vnet1Name
    vnet1mySqlSubnetIdentity: appVnetName.outputs.vnet1mySqlSubnetID   
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
