@description('Place keyvault in default region of target resourcegroup declared in main.bicep')
param location string
param envName string

// az policy add voor toevoegen van secrets oid // alleen van toepassing op assigned id 
// admin pw moet gestored kunnen worden

@description('The name of the User Assigned Identity.')
param managed_identity_name string= 'userid${uniqueString(resourceGroup().name)}' 

@description('Name of the key in the Key Vault')
param kv_key_name string = 'key${uniqueString(resourceGroup().name)}' 

@description('Specifies the name of the key vault. To make the name unique for redeployment testing purposes, a timestamp has been added in the name')
var keyVaultName = 'kv${envName}-${timestamp}'
param timestamp string = utcNow()
// param keyVaultName string = 'kv${envName}${uniqueString(resourceGroup().name)}'      // works for one time fresh deployment with no prior keyvault

@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.')
param tenantId string = subscription().tenantId
// param tenantId string = '7810209c-8fef-48a1-8881-d6946b6a7633'

@description('Specifies the permissions to keys in the vault. Valid values are: all, encrypt, decrypt, wrapKey, unwrapKey, sign, verify, get, list, create, update, import, delete, backup, restore, recover, and purge.')
param keysPermissions array = [
  'all'
]

@description('Specifies the permissions to secrets in the vault. Valid values are: all, get, list, set, delete, backup, restore, recover, and purge.')
param secretsPermissions array = [
'all'
]

@description('Specifices the permissions to certificates in the vault.')
param certificatesPermissions array = [
  'all'
]

@description('Specifies whether the key vault is a standard vault or a premium vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

resource keyvault_resource 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: true            // Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault
    enabledForDiskEncryption: true        // Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys
    enabledForTemplateDeployment: true    // Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Must enable this for IaC projects upon deployment for keyvault to work. 
    enableRbacAuthorization: false        // we dont have write permissions to make role assignments with our Techgrounds AD role 'Contributor'. We must make use of access policies.
    tenantId: tenantId
    createMode: 'default'
    enablePurgeProtection: false           // once enabled cannot be turned off.
    enableSoftDelete: true
    softDeleteRetentionInDays: 7          // min value 7 - 90 is standard
    publicNetworkAccess: 'Enabled'        // could be 'Disabled' but chances are for now I could lock myself out of my Keyvault
    accessPolicies: [
      {
        objectId: managed_identity.properties.principalId     //  when working with user assigned identity (legacy)
        tenantId: tenantId
        permissions: {
          keys: keysPermissions
          secrets: secretsPermissions
          certificates: certificatesPermissions
        }
      }]
    sku: {
      name: skuName
      family: 'A'
    }
    networkAcls: {
      defaultAction: 'Allow'          
      bypass: 'AzureServices'
      ipRules: [{
        value: '77.175.148.54'                        // my own public IP
      }]
    }
  }
}

resource managed_identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name:  managed_identity_name
  location: location
}

resource kv_key_resource 'Microsoft.KeyVault/vaults/keys@2023-02-01' = {
  name: kv_key_name
  parent: keyvault_resource
  properties: {
    attributes: {
      enabled: true
    }
    keySize: 2048              // Other possible values are 3072 or 4096
    kty: 'RSA'
    keyOps: [
      'encrypt'
      'decrypt'
      'sign'
      'verify'
      'wrapKey'
      'unwrapKey'
    ]
  }
}

resource disk_encryption 'Microsoft.Compute/diskEncryptionSets@2021-08-01' = {
  name: 'disk_encryption_sets'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    // encryptionType: 'EncryptionAtRestWithCustomerKey'
    rotationToLatestKeyVersionEnabled: true
    activeKey: {
      keyUrl: kv_key_resource.properties.keyUriWithVersion
      sourceVault: {
        id: keyvault_resource.id
      }
    }
  }
}

// gives disk encryption set access to Keyvault
resource vault_access_policy 'Microsoft.KeyVault/vaults/accessPolicies@2021-10-01' = {
  name: 'add'
  parent: keyvault_resource
  properties: {
    accessPolicies:[
      {
        tenantId: tenantId
        objectId: disk_encryption.identity.principalId
        permissions: {
          keys: [
            'get'
            'wrapKey'
            'unwrapKey'
            'encrypt'
            'decrypt'
          ]
          secrets: []
          certificates: []
        }
      }
    // gives managed ID acces to the vault
      // {
      //   tenantId: tenantId
      //   objectId: managed_identity.properties.principalId
      //   permissions: {
      //     keys: keysPermissions
      //     secrets: secretsPermissions
      //     certificates: certificatesPermissions
      //   }
      // }
    ]
  }
}


@description('Outputs to other modules that need reference to Keyvault or encryption')
// Outputs to other modules that need reference to Keyvault or encryption
output key_vault_resource_id string = keyvault_resource.id
output key_vault_url string = keyvault_resource.properties.vaultUri
output key_vault_name string = keyvault_resource.name
output managed_id_out string = managed_identity.id
output managed_id_name string = managed_identity_name
output diskencryptset_id string = disk_encryption.id
output kv_key_name string = kv_key_resource.name
