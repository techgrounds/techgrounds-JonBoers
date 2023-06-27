resource symbolicname 'Microsoft.KeyVault/vaults/accessPolicies@2022-07-01' = {
  name: 'string'
  parent: resourceSymbolicName
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
  }
}
