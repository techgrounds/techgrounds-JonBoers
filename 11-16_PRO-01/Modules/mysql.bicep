/* -------------------------------------------------------------------------- */
/*                              MySQL - DB Module                             */
/* -------------------------------------------------------------------------- */

// @description('The name of your application')
// param applicationName string

// @description('The environment (dev, prod)')
// @maxLength(4)
// param environment string = 'dev'

// @description('The number of this specific instance')
// @maxLength(3)
// param instanceNumber string

// @description('The Azure region where all resources in this example should be created')
// param location string

// @description('A list of tags to apply to the resources')
// param tags object

// @description('The name of the SQL logical server.')
// param serverName string = 'mysql-${applicationName}-${environment}-${instanceNumber}'

// @description('The name of the SQL Database.')
// param sqlDBName string = applicationName

// @description('The administrator username of the SQL logical server.')
// param administratorLogin string = 'sql${substring(replace(applicationName, '-', ''),0,8)}root'

// @description('The administrator password of the SQL logical server.')
// @secure()
// param administratorPassword string = newGuid()

// resource sqlServer 'Microsoft.DBforMySQL/servers@2017-12-01' = {
//   name: serverName
//   tags: tags
//   location: location
//   sku: {
//   name: 'B_Gen5_1'
//   }
//   properties: {
//     sslEnforcement: 'Enabled'
//     minimalTlsVersion: 'TLS1_2'
//     storageProfile: {
//       backupRetentionDays: 7
//       geoRedundantBackup: 'Disabled'
//       storageAutogrow: 'Enabled'
//       storageMB: 5120
//     }
//     version: '5.7'
//     createMode: 'Default'
//     administratorLogin: administratorLogin
//     administratorLoginPassword: administratorPassword
//   }
// }




  
// resource sqlFirewall 'Microsoft.DBforMySQL/servers/firewallRules@2017-12-01' = {
//   name: 'AllowWebserver'
//   parent: sqlServer
//   properties: {
//     startIpAddress: '10.10.10.0'
//     endIpAddress: '10.10.10.255'    
//   }
// }

// output db_url string = sqlServer.properties.fullyQualifiedDomainName
// output db_username string = administratorLogin
// output db_password string = administratorPassword

@description('Server Name for Azure database for MySQL')
param serverName string

@description('Database administrator login name')
@minLength(1)
param dbAdminLogin string

@description('Database administrator password')
@minLength(6)
@secure()
param dbAdminLoginPassword string

@description('Azure database for MySQL compute capacity in vCores (2,4,8,16,32)')
param skuCapacity int = 2

@description('Azure database for MySQL sku name ')
param skuName string = 'GP_Gen5_2'

@description('Azure database for MySQL Sku Size ')
param SkuSizeMB int = 5120

@description('Azure database for MySQL pricing tier')
@allowed([
  'Basic'
  'GeneralPurpose'
  'MemoryOptimized'
])
param SkuTier string = 'GeneralPurpose'

@description('Azure database for MySQL sku family')
param skuFamily string = 'Gen5'

@description('MySQL version')
@allowed([
  '5.6'
  '5.7'
  '8.0'
])
param mysqlVersion string = '8.0'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('MySQL Server backup retention days')
param backupRetentionDays int = 7

@description('Geo-Redundant Backup setting')
param geoRedundantBackup string = 'Disabled'

// @description('Virtual Network RuleName')
// param virtualNetworkRuleName string = 'AllowSubnet'

var firewallrules = [
  {
    Name: 'rule1AllowWebserver'
    StartIpAddress: '10.10.10.0'
    EndIpAddress: '10.10.10.255'
  }
  {
    Name: 'rule2AllowAdminServer'
    StartIpAddress: '10.20.20.0'
    EndIpAddress: '10.20.20.255'
  }
]

resource mysqlDbServer 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: serverName
  location: location
  sku: {
    name: skuName
    tier: SkuTier
    capacity: skuCapacity
    size: '${SkuSizeMB}'  //a string is expected here but a int for the storageProfile...
    family: skuFamily
  }
  properties: {
    createMode: 'Default'
    version: mysqlVersion
    administratorLogin: dbAdminLogin
    administratorLoginPassword: dbAdminLoginPassword
    storageProfile: {
      storageMB: SkuSizeMB
      backupRetentionDays: backupRetentionDays
      geoRedundantBackup: geoRedundantBackup
    }
  }

  // resource virtualNetworkRule 'virtualNetworkRules@2017-12-01' = {
  //   name: virtualNetworkRuleName
  //   properties: {
  //     virtualNetworkSubnetId: subnet.id
  //     ignoreMissingVnetServiceEndpoint: true
  //   }
  // }
}

@batchSize(1)
resource firewallRules 'Microsoft.DBforMySQL/servers/firewallRules@2017-12-01' = [for rule in firewallrules: {
  parent: mysqlDbServer
  name: '${rule.Name}'
  properties: {
    startIpAddress: rule.StartIpAddress
    endIpAddress: rule.EndIpAddress
  }
}]

output mysqlDbServerName string = mysqlDbServer.name
output mysqlDbServerResourceId string = mysqlDbServer.id
output mysqlDbServerFQDN string = mysqlDbServer.properties.fullyQualifiedDomainName
// output virtualNetworkRuleResourceId string = virtualNetworkRule.id
// output firewallRuleResourceIds array = [for rule in firewallRules: rule.id]
