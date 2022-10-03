Write-Output 'Disabling WinRM'
Disable-NetFirewallRule -DisplayGroup 'Windows Remote Management'
$winrmService = Get-Service -Name 'WinRM'
if ($winrmService.Status -eq 'Running') {
  Disable-PSRemoting -Force
}
Stop-Service -Name 'WinRM'
Set-Service -Name 'WinRM' -StartupType Disabled
