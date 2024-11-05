# Configuring Code Coverage

- Set environmnet (may not be required) and run the command

```
$env:MSYS2_ARG_CONV_EXCL="*" 
dotnet test --no-build --configuration Release /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura /p:CoverletOutput=./TestResults/Coverage/
```

Generate HTML Report

``` dotnet tool run reportgenerator  -reports:.\TestResults\Coverage\coverage.cobertura.xml -targetdir:./CodeCoverage -reporttypes:HtmlInline_AzurePipelines ````


