@description('Name for vNet 1')
param vnet1Name string

@description('Name for vNet 2')
param vnet2Name string

@description('Reference the parent in the peering resource')
resource vnet_webserver 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: vnet1Name}

resource VnetPeering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: vnet_webserver
  name: '${vnet1Name}-${vnet2Name}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vnet_webserver.id
    }
  }
}

@description('Reference the parent in the peering resource')
resource vmNamePrefix 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: vnet1Name}

resource vnetPeering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  parent: vmNamePrefix
  name: '${vnet2Name}-${vnet1Name}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vmNamePrefix.id
    }
  }
}
