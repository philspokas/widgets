// Define the parameters
param appServicePlanName string
param appServiceName string
param location string = resourceGroup().location
param sku string = 'F1'

// Resource for App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
    tier: 'Free'
  }
  properties: {
    perSiteScaling: false
    reserved: false
  }
}

// Resource for App Service
resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

output appServiceEndpoint string = 'https://${appServiceName}.azurewebsites.net'

