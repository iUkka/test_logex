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
}

$PACKAGE_ID = @($PACKAGE_ID,"defaultTestPackage") | Select-Object -First 1
$versionNumber = [int64](Get-Date -UFormat %s)
$outputFolder = "$defaultLocation\output"
New-Item "$outputFolder" -ItemType Directory -Force

Write-Host "Try to create ${PACKAGE_ID}:$versionNumber"
Import-Module SqlChangeAutomation
$project = (Get-ChildItem $defaultLocation -Recurse -Filter *.sqlproj ).fullname
if ($project)
{
    Write-Host "Current project: $project" -ForegroundColor Green

    $validatedProject = $project | Invoke-DatabaseBuild
    $buildArtifact = New-DatabaseBuildArtifact $validatedProject -PackageId $PACKAGE_ID -PackageVersion $versionNumber
    Export-DatabaseBuildArtifact $buildArtifact -Path "$outputFolder"

    if ((Get-Variable -Name NUGET_URL) -And (Get-Variable -Name NUGET_API_KEY))
    {
        Write-Host "Publish artifact $PACKAGE_ID version $versionNumber to $NUGET_URL" -ForegroundColor Green
        Publish-DatabaseBuildArtifact $buildArtifact -NuGetFeedUrl $NUGET_URL -NuGetApiKey $NUGET_API_KEY
    }
}
else
{
    Write-Host "Project file not found!" -foreground Red
    throw
}
