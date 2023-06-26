@description('Location for all resources.')
param location string = resourceGroup().location

param vnet1Name string = 'VNet1'
param vnet2Name string = 'VNet2'

resource vnet1 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.10.10.0/24']
    }
    subnets: [
      {
        name: 'Subnet1'
        properties: {
          addressPrefix: '10.10.10.0/24'
        }
      }
    ]
  }
}

resource vnet2 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.20.20.0/24']
    }
    subnets: [
      {
        name: 'Subnet2'
        properties: {
          addressPrefix: '10.20.20.0/24'
        }
      }
    ]
  }
}

resource vnet1Peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: '${vnet1.name}/vnetAPeer'
  properties: {
    remoteVirtualNetwork: {
      id: vnet2.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

resource vnetBPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: '${vnet2.name}/vnetBPeer'
  properties: {
    remoteVirtualNetwork: {
      id: vnet1.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}
