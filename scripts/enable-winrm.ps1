Write-Output 'Enabling WinRM'
Get-NetConnectionProfile | ForEach-Object { Set-NetConnectionProfile -Name $_.Name -NetworkCategory Private }
Enable-PSRemoting -Force
winrm quickconfig -q
winrm quickconfig -transport:http
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="800"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/listener?Address=*+Transport=HTTP '@{Port="5985"}'
Enable-NetFirewallRule -DisplayGroup 'Windows Remote Management'
Set-Service -Name 'WinRM' -StartupType Automatic
Restart-Service -Name 'WinRM'
