Write-Output 'Set WinRM start type to auto'
Set-Service -Name 'WinRM' -StartupType Automatic
