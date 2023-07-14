@description('Name for vNet 1')
param vnet1Name string 
param vnet1Id string
@description('Name for vNet 2')
param vnet2Name string 
param vnet2Id string

@description('Reference the parent in the peering resource')
resource appVnetName 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: vnet1Name}

resource VnetPeering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: appVnetName
  name: '${vnet1Name}-${vnet2Name}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: true
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vnet2Id
    }
  }
}

@description('Reference the parent in the peering resource')
resource ManagementVnetName 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: vnet2Name}

resource vnetPeering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: ManagementVnetName
  name: '${vnet2Name}-${vnet1Name}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: true
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vnet1Id
    }
  }
}
