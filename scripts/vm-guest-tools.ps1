if (!(Test-Path "C:\Windows\Temp\7z1900-x64.msi")) {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://www.7-zip.org/a/7z1900-x64.msi', 'C:\Windows\Temp\7z1900-x64.msi')
}

if (!(Test-Path "C:\Windows\Temp\7z1900-x64.msi")) {
    Start-Sleep 5; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://www.7-zip.org/a/7z1900-x64.msi', 'C:\Windows\Temp\7z1900-x64.msi')
}

cmd /c msiexec /qb /i C:\Windows\Temp\7z1900-x64.msi

if ("$env:PACKER_BUILDER_TYPE" -eq "vmware-iso") {
    Write-Host "Using VMware"

    if (Test-Path "C:\Users\vagrant\windows.iso") {
        Move-Item -force C:\Users\vagrant\windows.iso C:\Windows\Temp
    }

    if (!(Test-Path "C:\Windows\Temp\windows.iso")) {
        Try {
            # Disabling the progress bar speeds up IWR https://github.com/PowerShell/PowerShell/issues/2138
            $ProgressPreference = 'SilentlyContinue'
            $pageContentLinks = (Invoke-WebRequest('https://softwareupdate.vmware.com/cds/vmw-desktop/ws') -UseBasicParsing).Links | Where-Object { $_.href -Match "[0-9]" } | Select-Object href | ForEach-Object { $_.href.Trim('/') }
            $versionObject = $pageContentLinks | ForEach-Object { New-Object System.Version ($_) } | Sort-Object -Descending | Select-Object -First 1 -Property:Major,Minor,Build
            $newestVersion = $versionObject.Major.ToString() + "." + $versionObject.Minor.ToString() + "." + $versionObject.Build.ToString() | Out-String
            $newestVersion = $newestVersion.TrimEnd("`r?`n")

            $nextURISubdirectoryObject = (Invoke-WebRequest("https://softwareupdate.vmware.com/cds/vmw-desktop/ws/$newestVersion/") -UseBasicParsing).Links | Where-Object { $_.href -Match "[0-9]" } | Select-Object href | Where-Object { $_.href -Match "[0-9]" }
            $nextUriSubdirectory = $nextURISubdirectoryObject.href | Out-String
            $nextUriSubdirectory = $nextUriSubdirectory.TrimEnd("`r?`n")
            $newestVMwareToolsURL = "https://softwareupdate.vmware.com/cds/vmw-desktop/ws/$newestVersion/$nextURISubdirectory/windows/packages/tools-windows.tar"
            Write-Host "The latest version of VMware tools has been determined to be downloadable from $newestVMwareToolsURL"
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile("$newestVMwareToolsURL", 'C:\Windows\Temp\vmware-tools.tar')
        } Catch {
            Write-Host "Unable to determine the latest version of VMware tools. Falling back to hardcoded URL."
            (New-Object System.Net.WebClient).DownloadFile('https://softwareupdate.vmware.com/cds/vmw-desktop/ws/16.1.1/17801498/windows/packages/tools-windows.tar', 'C:\Windows\Temp\vmware-tools.tar')
        }

        cmd /c "C:\PROGRA~1\7-Zip\7z.exe" x C:\Windows\Temp\vmware-tools.tar -oC:\Windows\Temp
        Move-Item C:\Windows\Temp\VMware-tools-windows-*.iso C:\Windows\Temp\windows.iso
        Try {
            Remove-Item "C:\Program Files (x86)\VMWare" -Recurse -Force -ErrorAction Stop
        } Catch {
            Write-Host "Directory didn't exist to be removed."
        }
    }

    cmd /c "C:\PROGRA~1\7-Zip\7z.exe" x C:\Windows\Temp\windows.iso -oC:\Windows\Temp\VMWare
    cmd /c C:\Windows\Temp\VMWare\setup.exe /S /v"/qn REBOOT=R\"

    Remove-Item -Force "C:\Windows\Temp\vmware-tools.tar"
    Remove-Item -Force "C:\Windows\Temp\windows.iso"
    Remove-Item -Force -Recurse "C:\Windows\Temp\VMware"
}

if ("$env:PACKER_BUILDER_TYPE" -eq "virtualbox-iso") {
    Write-Host "Using Virtualbox"

    if (Test-Path "C:\Users\vagrant\VBoxGuestAdditions.iso") {
        Move-Item -Force C:\Users\vagrant\VBoxGuestAdditions.iso C:\Windows\Temp
    }

    if (!(Test-Path "C:\Windows\Temp\VBoxGuestAdditions.iso")) {
        Try {
            $pageContentLinks = (Invoke-WebRequest('https://download.virtualbox.org/virtualbox') -UseBasicParsing).Links | Where-Object { $_.href -Match "[0-9]" } | Select-Object href | Where-Object { $_.href -NotMatch "BETA" } | Where-Object { $_.href -NotMatch "RC" } | Where-Object { $_.href -Match "[0-9]\.[0-9]" } | ForEach-Object { $_.href.Trim('/') }
            $versionObject = $pageContentLinks | ForEach-Object { New-Object System.Version ($_) } | Sort-Object -Descending | Select-Object -First 1 -Property:Major,Minor,Build
            $newestVersion = $versionObject.Major.ToString() + "." + $versionObject.Minor.ToString() + "." + $versionObject.Build.ToString() | Out-String
            $newestVersion = $newestVersion.TrimEnd("`r?`n")

            $nextURISubdirectoryObject = (Invoke-WebRequest("https://download.virtualbox.org/virtualbox/$newestVersion/") -UseBasicParsing).Links | Select-Object href | Where-Object { $_.href -Match "GuestAdditions" }
            $nextUriSubdirectory = $nextURISubdirectoryObject.href | Out-String
            $nextUriSubdirectory = $nextUriSubdirectory.TrimEnd("`r?`n")
            $newestVboxToolsURL = "https://download.virtualbox.org/virtualbox/$newestVersion/$nextUriSubdirectory"
            Write-Host "The latest version of VirtualBox tools has been determined to be downloadable from $newestVboxToolsURL"
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile("$newestVboxToolsURL", 'C:\Windows\Temp\VBoxGuestAdditions.iso')
        } Catch {
            Write-Host "Unable to determine the latest version of VBox tools. Falling back to hardcoded URL."
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://download.virtualbox.org/virtualbox/6.1.18/VBoxGuestAdditions_6.1.18.iso', 'C:\Windows\Temp\VBoxGuestAdditions.iso')
        }
    }

    cmd /c "C:\PROGRA~1\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox
    Get-ChildItem "C:\Windows\Temp\virtualbox\cert\" -Filter vbox*.cer | Foreach-Object { C:\Windows\Temp\virtualbox\cert\VBoxCertUtil add-trusted-publisher $_.FullName --root $_.FullName }
    cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S

    Remove-Item -Force "C:\Windows\Temp\VBoxGuestAdditions.iso"
    Remove-Item -Force -Recurse "C:\Windows\Temp\virtualbox"
}

if ("$env:PACKER_BUILDER_TYPE" -eq "parallels-iso") {
    Write-Host "Using Parallels"

    if (Test-Path "C:\Users\vagrant\prl-tools-win.iso") {
        Move-Item -Force C:\Users\vagrant\prl-tools-win.iso C:\Windows\Temp
        cmd /c "C:\PROGRA~1\7-Zip\7z.exe" x C:\Windows\Temp\prl-tools-win.iso -oC:\Windows\Temp\parallels
        cmd /c C:\Windows\Temp\parallels\PTAgent.exe /install_silent

        Remove-Item -Force "C:\Windows\Temp\prl-tools-win.iso"
        Remove-Item -Force -Recurse "C:\Windows\Temp\parallels"
    }
}

cmd /c msiexec /qb /x C:\Windows\Temp\7z1900-x64.msi
