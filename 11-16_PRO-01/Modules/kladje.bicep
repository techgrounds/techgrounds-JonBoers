param environment string

@description('VMSS settings to follow')
resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2021-11-01' = {
  name: name_vmss
  location: location
  tags: {
    vnet: name_vnet_webserver
    location: location
    id: 'vm scale set'
    project: 'IaC'
  }
  sku: {
    tier: 'Standard'
    name: vm_size
    capacity: 1
  }
  properties: {
    singlePlacementGroup: true
    platformFaultDomainCount: 1
    overprovision: true
    automaticRepairsPolicy: {
      enabled: true
    }
    upgradePolicy: {
      mode: 'Rolling'
      rollingUpgradePolicy: {
        prioritizeUnhealthyInstances: true
      }
    }
    additionalCapabilities: {
      hibernationEnabled: false
      ultraSSDEnabled: false
    }
    virtualMachineProfile: {
      userData: apache_script
      storageProfile: {
        imageReference: {
          offer: '0001-com-ubuntu-server-focal'
          version: 'latest'
          publisher: 'canonical'
          sku: vm_sku
        }
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
          osType: 'Linux'
          managedDisk: {
            storageAccountType: 'StandardSSD_LRS'
            diskEncryptionSet: {
              id: diskencryption
            }
          }
        }
      }
      osProfile: {
        computerNamePrefix: name_vm
        adminUsername: webadmin_username
        adminPassword: webadmin_password
        linuxConfiguration: {
          disablePasswordAuthentication: false
          provisionVMAgent: false                               
        }
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: '${environment}-VMSS-interface'
            properties: {
              networkSecurityGroup: {
                id: nsg_backend
              }
              enableAcceleratedNetworking: false
              enableIPForwarding: false
              primary: true
              ipConfigurations: [
                {
                name: '${environment}-VMSS-IPconfig'
                properties: {
                  privateIPAddressVersion: 'IPv4'
                  subnet: {
                    id: vnet_webserver.properties.subnets[0].id                                 // backend subnet
                  }
                  applicationGatewayBackendAddressPools: [
                    {
                      id: app_gateway.properties.backendAddressPools[0].id                    
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
            name: '${environment}-healthname'
            properties: {
              enableAutomaticUpgrade: true
              autoUpgradeMinorVersion: false
              publisher: 'Microsoft.ManagedServices'
              type: 'ApplicationHealthLinux'
              typeHandlerVersion: '1.0'
              settings: {
                port: 80
                protocol: 'Http'
                requestPath: ''
              }
            }
          }
        ]
      } 
    }
  }
}
