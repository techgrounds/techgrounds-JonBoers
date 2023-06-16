param appPrdVnetName string = 'app-prd-vnet'
param managementPrdVnetName string = 'management-prd-vnet'
param location string = 'westeurope'
param subnet1Prefix string = '10.10.10.0/24'
param subnet2Prefix string = '10.20.20.0/24'
param nsgName string = 'your-nsg-name'
param vmName string = 'your-vm-name'
param vmSize string = 'Standard_DS2_v2'
param backupRetentionDays int = 7
param trustedIpAddress string = 'your-trusted-ip-address'

resource vnet1 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: appPrdVnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'app-prd-subnet'
        properties: {
          addressPrefix: subnet1Prefix
          networkSecurityGroup: {
            id: resourceId('Microsoft.Network/networkSecurityGroups', nsgName)
          }
        }
      }
    ]
  }
}

resource vnet2 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: managementPrdVnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'management-prd-subnet'
        properties: {
          addressPrefix: subnet2Prefix
          networkSecurityGroup: {
            id: resourceId('Microsoft.Network/networkSecurityGroups', nsgName)
          }
        }
      }
    ]
  }
}

resource vm1 'Microsoft.Compute/virtualMachineScaleSets@2021-07-01' = {
  name: 'webserver-scaleset'
  location: location
  properties: {
    sku: {
      name: 'Standard_DS2_v2'
      tier: 'Standard'
    }
    upgradePolicy: {
      mode: 'Automatic'
    }
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
          encryptionSettings: {
            enabled: true
          }
        }
        dataDisks: [
          {
            createOption: 'Empty'
            diskSizeGB: 128
            encryptionSettings: {
              enabled: true
            }
          }
        ]
      }
      osProfile: {
        computerNamePrefix: 'webserver'
        adminUsername: 'your-username'
        adminPassword: 'your-password'
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: 'nic-config'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: 'ip-config'
                  properties: {
                    subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets', appPrdVnetName, 'app-prd-subnet')
                    }
                    loadBalancerBackendAddressPools: [
                      {
                        id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', 'your-load-balancer-name')
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
      extensionProfile: {
        extensions: [
          {
            name: 'backup-extension'
            properties: {
              backupName: 'webserver-backup'
              backupPolicyId: 'your-backup-policy-id'
              backupRetentionDays: backupRetentionDays
            }
          }
        ]
      }
    }
  }
}

resource vm2 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: 'management-server'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS2_v2'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        encryptionSettings: {
          enabled: true
        }
      }
    }
    osProfile: {
      computerName: 'management-server'
      adminUsername: 'your-username'
      adminPassword: 'your-password'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId('Microsoft.Network/networkInterfaces', 'your-nic-name')
        }
      ]
    }
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH-RDP-Rules'
        properties: {
          protocol: 'Tcp'
          sourceAddressPrefix: trustedIpAddress
          destinationPortRange: '22'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'Webserver-Rules'
        properties: {
          protocol: 'Tcp'
          sourceAddressPrefix: 'your-management-server-ip'
          destinationPortRange: '80'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 101
          direction: 'Inbound'
        }
      }
      {
        name: 'Webserver-SSH-Rules'
        properties: {
          protocol: 'Tcp'
          sourceAddressPrefix: 'your-management-server-ip'
          destinationPortRange: '22'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 102
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: 'management-server-public-ip'
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    dnsSettings: {
      domainNameLabel: 'management-server'
    }
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'your-storage-account-name'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {}
}

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: 'your-key-vault-name'
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'Standard'
    }
    tenantId: 'your-tenant-id'
    accessPolicies: [
      {
        tenantId: 'your-tenant-id'
        objectId: 'your-object-id'
        permissions: {
          keys: ['all']
          secrets: ['all']
          certificates: ['all']
        }
      }
    ]
  }
}

resource recoveryServiceVault 'Microsoft.RecoveryServices/vaults@2021-06-01' = {
  name: 'your-recovery-service-vault-name'
  location: location
  properties: {
    sku: {
      name: 'RS0'
    }
    tenantId: 'your-tenant-id'
  }
}
