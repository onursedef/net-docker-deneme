FROM mcr.microsoft.com/dotnet/sdk:6.0-focal as build
WORKDIR /source
COPY . .
RUN dotnet restore "./WebApplication2/WebApplication2.csproj" --disable-parallel
RUN dotnet publish "./WebApplication2/WebApplication2.csproj" -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/sdk:6.0-focal
WORKDIR /app
COPY --from=build /app ./

EXPOSE 5000

ENTRYPOINT ["dotnet", "WebApplication2.dll"]