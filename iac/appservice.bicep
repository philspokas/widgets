// App service params
param appServicePlanName string = 'widgets-plan-dev'
param appServiceName string = 'widgets-app-dev'
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


resource allowAllWindowsAzureIps 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: sqlServer
  name: 'AllowAllAzureIps'
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}


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
        {
          name: 'DOTNET_ENVIRONMENT'
          value: 'Development'
        }
      ]
      minTlsVersion: '1.2'
      ftpsState: 'FtpsOnly'
    }
  }
}

resource webSiteConnectionStrings 'Microsoft.Web/sites/config@2020-12-01' = {
  parent: appService
  name: 'connectionstrings'
  properties: {
    DefaultConnection: {
      value: 'Data Source=tcp:${sqlServer.properties.fullyQualifiedDomainName},1433;Initial Catalog=${sqlDBName};User Id=${adminLogin}@${sqlServer.properties.fullyQualifiedDomainName};Password=${adminPassword};'
      type: 'SQLAzure'
    }
  }
}


// outputs
output appServiceEndpoint string = 'https://${appServiceName}.azurewebsites.net'

