New-AzResourceGroup -Name Project1.0 -Location uksouth
New-AzResourceGroupDeployment -ResourceGroupName V1.0test -TemplateFile nieuweopzet.bicep

New-AzResourceGroupDeployment -Name testdeploy  -ResourceGroupName V1.0test -TemplateFile nieuweopzet.bicep

New-AzSubscriptionDeployment -Location uksouth -TemplateFile main.bicep