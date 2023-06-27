targetScope = 'subscription'

@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

@description('Make general resource group for deployment in certain region')
// Make a general resource group for deployment in a region
param resourceGroupName string = 'testrgV1.0'
param location string = deployment().location // locate resources at location declared with the deployment command
resource rootgroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

 @description('deploy vnet1') 

module appVnetName 'Modules/vnet1.bicep' = {
  name: 'webserverVnet'
  scope: rootgroup
  params: {
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: location
  }
}

@description('deploy vnet2') 

module ManagementVnetName 'Modules/vnet2.bicep' = {
  name: 'adminvnet'
  scope: rootgroup
  params: {
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: location
    patchMode: 'manual' //will be done by company admins to avoid unscheduled downtime of vm
     
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
    vnet1Id : appVnetName.outputs.vnet1Id
    vnet2Id : ManagementVnetName.outputs.vnet2Id

    }
  }
