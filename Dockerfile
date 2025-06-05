# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy solution and project files
COPY BookDataGenerator/*.csproj ./BookDataGenerator/
RUN dotnet restore "BookDataGenerator/BookDataGenerator.csproj"

# Copy everything else
COPY . .

# Publish the app
WORKDIR "/src/BookDataGenerator"
RUN dotnet publish "BookDataGenerator.csproj" -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app
EXPOSE 80

# Copy published app
COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=http://*:$PORT
ENTRYPOINT ["dotnet", "BookDataGenerator.UI.dll"]
