# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Create solution structure
RUN mkdir -p BookDataGenerator.UI

# Copy project file
COPY BookDataGenerator.UI/BookDataGenerator.UI.csproj ./BookDataGenerator.UI/
RUN dotnet restore "BookDataGenerator.UI/BookDataGenerator.UI.csproj"

# Copy all source files
COPY . .
RUN dotnet publish "BookDataGenerator.UI/BookDataGenerator.UI.csproj" \
    -c Release \
    -o /app/publish \
    --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app
EXPOSE 80

# Required for Render
ENV ASPNETCORE_URLS=http://+:80 \
    DOTNET_RUNNING_IN_CONTAINER=true

# Copy published app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "BookDataGenerator.UI.dll"]
