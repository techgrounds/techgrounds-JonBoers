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

 @description('deploy main') 

module main 'main.bicep' = {
  name: 'testdeployment'
  scope: rootgroup
  params: {
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: location
  }
}

@description('deploy vnet2') 

module adminVnet 'vnet2.bicep' = {
  name: 'adminvnet'
  scope: rootgroup
  params: {
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: location
    patchMode: 'manual' //will be done by company admins to avoid unscheduled downtime of vm
    enableHotpatching: true
    securityType: 'confidentialVM'
    secureBoot: false
    vTPM: true   
  }
}
