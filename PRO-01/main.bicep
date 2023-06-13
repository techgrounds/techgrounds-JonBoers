param location string = 'westus3'
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

var appServicePlanName = 'toy-product-launch-plan'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'yodasuitsforcats'
  location: 'westus3'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'toy-product-launch-plan-starter'
  location: 'westus3'
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: 'Yoda-Hoodie-Brown-1'
  location: 'westus3'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true    
  }
}
