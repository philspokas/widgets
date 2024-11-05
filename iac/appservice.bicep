// App service params
param appServicePlanName string
param appServiceName string
param location string = resourceGroup().location

@description('The name of the SQL logical server.')
param serverName string = uniqueString('sql', resourceGroup().id)

@description('The name of the SQL Database.')
param sqlDBName string = 'widgets'

@description('The administrator username of the SQL logical server.')
param adminLogin string

@description('The administrator password of the SQL logical server.')
@secure()
param adminPassword string

// Resource for App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Free'
  }
  kind: 'linux'
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
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_STACK' 
          value: 'DOTNETCORE' 
        } 
        { 
          name: 'DOTNET_VERSION' 
          value: '8.0'
        }
      ]
      minTlsVersion: '1.2'
      ftpsState: 'FtpsOnly'
    }
  }
}

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: sqlDBName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

// outputs
output appServiceEndpoint string = 'https://${appServiceName}.azurewebsites.net'

