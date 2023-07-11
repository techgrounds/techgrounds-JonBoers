/* -------------------------------------------------------------------------- */
/*                              MySQL - DB Module                             */
/* -------------------------------------------------------------------------- */

@description('The name of your application')
param applicationName string

@description('The environment (dev, prod)')
@maxLength(4)
param environment string = 'dev'

@description('The number of this specific instance')
@maxLength(3)
param instanceNumber string

@description('The Azure region where all resources in this example should be created')
param location string

@description('A list of tags to apply to the resources')
param tags object

@description('The name of the SQL logical server.')
param serverName string = 'mysql-${applicationName}-${environment}-${instanceNumber}'

@description('The name of the SQL Database.')
param sqlDBName string = applicationName

@description('The administrator username of the SQL logical server.')
param administratorLogin string = 'sql${substring(replace(applicationName, '-', ''),0,8)}root'

@description('The administrator password of the SQL logical server.')
@secure()
param administratorPassword string = newGuid()

resource sqlServer 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: serverName
  tags: tags
  location: location
  sku: {
  name: 'B_Gen5_1'
  }
  properties: {
    sslEnforcement: 'Enabled'
    minimalTlsVersion: 'TLS1_2'
    storageProfile: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
      storageAutogrow: 'Enabled'
      storageMB: 5120
    }
    version: '5.7'
    createMode: 'Default'
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorPassword
  }
}

resource sqlDatabase 'Microsoft.DBforMySQL/servers/databases@2017-12-01' = {
  name: sqlDBName
  parent: sqlServer
  properties: {
    charset: 'UTF8'
  }
}

resource sqlFirewall 'Microsoft.DBforMySQL/servers/firewallRules@2017-12-01' = {
  name: 'AllowWebserver'
  parent: sqlServer
  properties: {
    startIpAddress: '10.10.10.0'
    endIpAddress: '10.10.10.255'    
  }
}

output db_url string = sqlServer.properties.fullyQualifiedDomainName
// output db_username string = administratorLogin
// output db_password string = administratorPassword
