targetScope = 'subscription'

// @description('Admin username')
// param adminUsername string

// @description('Admin password')
// @secure()
// param adminPassword string

@description('Make general resource group for deployment in certain region')
// Make a general resource group for deployment in a region
param resourceGroupName string = 'testrgV1.0'
param location string = deployment().location // locate resources at location declared with the deployment command
resource rootgroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

@description('Deploy network peering module')
// Deploy network peering module
module peering 'Modules/peering.bicep' = {
  name: 'peering_deployment'
  scope: rootgroup
  params: {
    vnet1Name : vnet1.outputs.vnet1Name
    name_vnet_adminserver: network.outputs.vnet_name_adminserver
    peer_web_vnet: network.outputs.vnet_id_webserver
    peer_admin_vnet: network.outputs.vnet_id_adminserver
    }
  }

module vnet1 'Modules/vnet1.bicep' = {
  
}
