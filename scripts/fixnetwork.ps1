# You cannot enable Windows PowerShell Remoting on network connections that are set to Public
# Spin through all the network locations and if they are set to Public, set them to Private
# For more info, see:
# http://blogs.msdn.com/b/powershell/archive/2009/04/03/setting-network-location-to-private.aspx

function Set-NetworkTypeToPrivate {
  [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPositionalParameters', '')]
  param()
  # Network location feature was only introduced in Windows Vista - no need to bother with this
  # if the operating system is older than Vista
  if ([environment]::OSVersion.version.Major -lt 6) { return }

  # You cannot change the network location if you are joined to a domain, so abort
  if (1, 3, 4, 5 -contains (Get-CimInstance win32_computersystem).DomainRole) { return }

  # Get network connections
  $connections = Get-NetConnectionProfile

  $connections | ForEach-Object {
    Write-Output "$($_.Name) category was previously set to $($_.NetworkCategory)"
    Set-NetConnectionProfile -Name $_.Name -NetworkCategory Private
    Write-Output "$($_.Name) changed to category $($_.NetworkCategory)"
  }
}

Set-NetworkTypeToPrivate
