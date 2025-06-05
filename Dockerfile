# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy project files and restore dependencies
COPY BookDataGenerator.UI/BookDataGenerator.csproj ./BookDataGenerator.UI/
RUN dotnet restore "BookDataGenerator.UI/BookDataGenerator.csproj"

# Copy everything else and build
COPY . .
RUN dotnet publish "BookDataGenerator.UI/BookDataGenerator.csproj" \
    -c Release \
    -o /app/publish \
    --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app

# Install ASP.NET Core runtime for Blazor Server
RUN apt-get update && \
    apt-get install -y aspnetcore-runtime-7.0 && \
    rm -rf /var/lib/apt/lists/*

# Copy published app
COPY --from=build /app/publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "BookDataGenerator.UI.dll"]
