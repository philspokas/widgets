# Widgets Coalesce Sample

Simple Coalesce project used to demonstrate DevOps concepts

## Build stuff
- remove extra dbset
- Set Development env to avoid auth
- No LocalDB support on ARM

## Container Build
- EF requires culture so use base container image that supports it
- build the web csproj into build
- note dll name in Dockerfile: case matters
- ```npm run build``` for production as vite server will not run by default in the container
- 

### Issues
- 


