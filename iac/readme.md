# Bicep Samples

Sample bicep files to get started and familiar with Bicep

## Tooling

- Azure CLI
- Bicep extension in VSCode

## Deploymnets with AZ CLI

Eeploy a resource group at subscription scope:
Paarameters override defaults in the script

``` 
az deployment sub create --name rg1 --location westus2 --template-file main.bicep --parameters groupName=excercise-pcs location=westus2
```

Resource Group scope:
```
az deployment group create --name dep1 --resource-group rg1 --template-file storage.bicep
```

## Deploymnets with Azure PowerShell

Subscription scope:
```
New-AzSubscriptionDeployment -location westus2 -templatefile main.bicep -groupName "ex-vnets"

```

Resource Group scope:
```
New-AzResourceGroupDeployment -ResourceGroupName <resource-group-name> -TemplateFile <path-to-template>
```


## Decompiling
```
az group export --name "your_resource_group_name" > main.json
az bicep decompile --file main.json
```
