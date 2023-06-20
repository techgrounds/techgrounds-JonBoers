New-AzResourceGroup -Name TestRG -Location uksouth
New-AzResourceGroupDeployment -ResourceGroupName TestRG -TemplateFile main.bicep
