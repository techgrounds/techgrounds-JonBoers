

@description('The Azure Region into which the resources are deployed.')
param location string

@secure()
@description('The admin username.')
param adminUserName string

@secure()
@description('The admin password.')
param adminPassword string

@description('Name of the disk encryption set')
param DiskEncryptionSetName string

@description('name of the Keyvault')
param KeyVaultName string

resource Keyvault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: KeyVaultName
  location: location
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  properties: {
    accessPolicies: [
      {
        applicationId: 'string'
        objectId: 'string'
        permissions: {
          certificates: [
            'string'
          ]
          keys: [
            'string'
          ]
          secrets: [
            'string'
          ]
          storage: [
            'string'
          ]
        }
        tenantId: 'string'
      }
    ]
    createMode: 'default'
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enablePurgeProtection: bool
    enableRbacAuthorization: false
    enableSoftDelete: bool
    networkAcls: {
      bypass: 'string'
      defaultAction: 'string'
      ipRules: [
        {
          value: 'string'
        }
      ]
      virtualNetworkRules: [
        {
          id: 'string'
          ignoreMissingVnetServiceEndpoint: bool
        }
      ]
    }
    provisioningState: 'string'
    publicNetworkAccess: 'string'
    sku: {
      family: 'A'
      name: 'string'
    }
    softDeleteRetentionInDays: int
    tenantId: 'string'
    vaultUri: 'string'
  }
}

resource diskEncryptionSet 'Microsoft.Compute/diskEncryptionSets@2022-07-02' = {
  name: DiskEncryptionSetName 
  location: location
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  identity: {
    type: 'string'
    userAssignedIdentities: {}
  }
  properties: {
    activeKey: {
      keyUrl: 'string'
      sourceVault: {
        id: 'string'
      }
    }
    encryptionType: 'string'
    federatedClientId: 'string'
    rotationToLatestKeyVersionEnabled: true
    }
}
