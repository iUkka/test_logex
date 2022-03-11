# escape=`
FROM mcr.microsoft.com/dotnet/framework/runtime:3.5-windowsservercore-ltsc2019
USER ContainerAdministrator

COPY "Docker/toBaseImage" "/"

SHELL ["C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe", "-command"]

RUN setx /M PATH $(${Env:PATH} + \";${Env:ProgramFiles}\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\" + \";${Env:ProgramFiles}\Microsoft SQL Server\130\Tools\Binn\"); `
    $ErrorActionPreference = 'Stop'; `
    $ProgressPreference = 'SilentlyContinue'; `
    & c:\install\SQL2019-SSEI-Expr.exe HIDEPROGRESSBAR=1 /Quiet Action=Download /MediaType=LocalDB MEDIAPATH=c:\install *> null; `
    Write-Host "Processing VC_redist.x64.exe"; `
    Start-Process -Wait -filepath c:\install\VC_redist.x64.exe -ArgumentList "/quiet","/passive","/norestart"; `
    Write-Host "Processing msodbcsql"; `
    Start-Process -Wait -filepath C:\Windows\System32\msiexec.exe -ArgumentList "/i","C:\install\msodbcsql_17.3.0.1_x64.msi","/quiet","/passive","/qn","IACCEPTMSODBCSQLLICENSETERMS=YES"; `
    Write-Host "Processing MsSqlCmdLnUtils"; `
    Start-Process -Wait -filepath C:\Windows\System32\msiexec.exe -ArgumentList  "/i","C:\install\MsSqlCmdLnUtils.msi","/qn","IACCEPTMSSQLCMDLNUTILSLICENSETERMS=YES"; `
    $ErrorActionPreference = 'Continue'; `
    $stopTime = (get-date).AddMinutes(2); `
    while(!(Test-Path c:\install\en-US\SqlLocalDB.msi)) {  `
        Write-Host "'Waiting for c:\install\en-US\SqlLocalDB.msi'"; `
        if((get-date) -gt $stopTime) { throw 'timout expired'} `
        Start-Sleep -Seconds 5; `
    }; `
    $stopTime = (get-date).AddMinutes(2); `
    while(!(((Get-Item c:\install\en-US\SqlLocalDB.msi).length/1MB) -gt 45)) {  `
        Write-Host "Waiting for correct size of c:\install\en-US\SqlLocalDB.msi"; `
        if((get-date) -gt $stopTime) { throw 'timout expired'} `
        Start-Sleep -Seconds 5; `
    }; `
    Start-Sleep -Seconds 5; `
    Write-Host "Download complete"; `
    $ErrorActionPreference = 'Stop'; `
    if (get-process SQL*-Expr* ) { Write-host "Killing unwanted SQL processes"; get-process -name SQL*-Expr*; get-process -name SQL*-Expr* | Stop-Process -Force; Start-Sleep -Seconds 3 }; `
    Write-Host "Processing SqlLocalDB.msi"; `
    Start-Process -Wait -filepath C:\Windows\System32\msiexec.exe -ArgumentList "/i","C:\install\en-US\SqlLocalDB.msi","/qn","IAcceptSqlLocalDBLicenseTerms=YES"; `
    wmic product get name,version /format:csv; `
    Remove-Item -path c:\install -recurse

RUN Get-PackageProvider NuGet -ForceBootstrap | Out-Null;`
    Import-PackageProvider PowerShellGet -Force; `
    Install-PackageProvider Nuget -Force; `
    Install-Module PowerShellGet -MinimumVersion 1.6 -Force

RUN Get-PackageProvider NuGet -ForceBootstrap | Out-Null; `
    Import-Module PowerShellGet; `
    Install-Module SqlChangeAutomation -AcceptLicense -Verbose -Force; `
    Get-Module
