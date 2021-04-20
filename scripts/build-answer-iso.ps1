$root = Resolve-Path -Path "$PSScriptRoot\.."
$scripts = "$root\scripts"

$isoFolder = "$root\answer-iso"
$isoScriptsFolder = "$isoFolder\scripts"
$isoFile = "$isoFolder\answer.iso"

if (Test-Path -Path $isoScriptsFolder)
{
    Remove-Item -Path $isoScriptsFolder -Force -Recurse
}

if (Test-Path -Path $isoFile)
{
    Remove-Item -Path $isoFile -Force
}

mkdir $isoScriptsFolder

Copy-Item -Path "$root\answer_files\10\Autounattend.xml" -Destination $isoScriptsFolder
Copy-Item -Path "$scripts\fixnetwork.ps1" -Destination $isoScriptsFolder
Copy-Item -Path "$scripts\disable-screensaver.ps1" -Destination $isoScriptsFolder
Copy-Item -Path "$scripts\disable-winrm.ps1" -Destination $isoScriptsFolder
Copy-Item -Path "$scripts\enable-winrm.ps1" -Destination $isoScriptsFolder
Copy-Item -Path "$scripts\microsoft-updates.bat" -Destination $isoScriptsFolder
Copy-Item -Path "$scripts\win-updates.ps1" -Destination $isoScriptsFolder

$textFile = "$isoScriptsFolder\Autounattend.xml"

$c = Get-Content -Encoding UTF8 $textFile

# Enable UEFI and disable Non EUFI
$c | % { $_ -replace '<!-- Start Non UEFI -->','<!-- Start Non UEFI' } | % { $_ -replace '<!-- Finish Non UEFI -->','Finish Non UEFI -->' } | % { $_ -replace '<!-- Start UEFI compatible','<!-- Start UEFI compatible -->' } | % { $_ -replace 'Finish UEFI compatible -->','<!-- Finish UEFI compatible -->' } | sc -Path $textFile

& "$root\mkisofs.exe" -r -iso-level 4 -UDF -o $isoFile $isoScriptsFolder

if (Test-Path -Path $isoScriptsFolder)
{
    Remove-Item -Path $isoScriptsFolder -Force -Recurse
}
