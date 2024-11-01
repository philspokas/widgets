FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS final
WORKDIR /app

COPY ./build /app

ENV \
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    DOTNET_ENVIRONMENT=Development

RUN apk add --no-cache \
    icu-data-full \
    icu-libs

USER $APP_UID

ENTRYPOINT ["dotnet", "Phil.Widgets.Web.dll"]
