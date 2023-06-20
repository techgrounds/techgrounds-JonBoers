New-AzResourceGroup -Name Project1.0 -Location uksouth
New-AzResourceGroupDeployment -ResourceGroupName RGProject -TemplateFile main.bicep
