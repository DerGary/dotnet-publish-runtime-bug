FROM mcr.microsoft.com/dotnet/sdk:7.0.401-jammy-amd64 AS Source
WORKDIR /code
COPY . .


FROM Source AS DoesWork
WORKDIR /code/Test2
RUN dotnet restore -r linux-musl-x64 /p:PublishReadyToRun=true
RUN dotnet publish --self-contained=true --runtime=linux-musl-x64 -o ./bin/publish /p:PublishReadyToRun=true -c Release --disable-parallel

FROM Source AS DoesNotWork
WORKDIR /code/Test3
RUN dotnet restore -r linux-musl-x64 /p:PublishReadyToRun=true
RUN dotnet publish --self-contained=true --runtime=linux-musl-x64 -o ./bin/publish /p:PublishReadyToRun=true -c Release --disable-parallel
