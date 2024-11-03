targetScope = 'subscription'

param groupName string = 'default-1'
param location string = 'westus2'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: groupName
  location: location
}

