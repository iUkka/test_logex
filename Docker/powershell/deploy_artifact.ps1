$ErrorActionPreference = 'Stop'
$defaultLocation = "c:\project"
Set-Location -Path $defaultLocation
if ( Test-Path .env )
{
    Get-Content .env | Foreach-Object{
        $var = $_.Split('=')
        if (Get-Variable -Name $var[0] -errorAction 'SilentlyContinue') {
            Set-Variable -Name $var[0] -Value $var[1] -Force
        } else
        {
            New-Variable -Name $var[0] -Value $var[1]
        }
    }
} else {
    throw ".env file not found!"
}

Import-Module SqlChangeAutomation
$PACKAGE_ID = @($PACKAGE_ID,"defaultTestPackage") | Select-Object -First 1
Write-host "Try to find $PACKAGE_ID nuget file"
$lastFile = (Get-ChildItem $defaultLocation -Recurse -Filter ${PACKAGE_ID}*.nupkg | Sort-Object LastWriteTime | Select-Object -last 1 ).fullname
if ($lastFile)
{
    $versionNumber = $lastFile -replace '.*\.(\d+)\.nupkg', '$1'
    Write-Host "File is $lastFile, version is $versionNumber"
    Write-Host "DB Host: $DB_HOST" -ForegroundColor Green
    Write-Host "DB base: $DB_NAME" -ForegroundColor Green
    Write-Host "DB user: $DB_USER" -ForegroundColor Green
    $production = New-DatabaseConnection -ServerInstance $DB_HOST -Database $DB_NAME -Username $DB_USER -Password $DB_PASSWORD
    if ($production | Test-DatabaseConnection)
    {
        # Create the deployment artifact
        $dbRelease = New-DatabaseReleaseArtifact -Source $lastFile -Target $production
        # Deploy the project
        Use-DatabaseReleaseArtifact $dbRelease -DeployTo $production
    } else {
        Write-Host "Connection to $DB_HOST database $DB_NAME failed" -ForegroundColor Red
        throw
    }
} else {
    Write-Host "Nuget file not found, exiting" -ForegroundColor Red
    throw
}
