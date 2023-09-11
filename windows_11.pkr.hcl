packer {
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = "~> 1"
    }
    parallels = {
      source  = "github.com/hashicorp/parallels"
      version = "~> 1"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = "~> 1"
    }
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = "~> 1"
    }
  }
}

variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "262144"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "iso_checksum" {
  type    = string
  default = "none"
}

variable "iso_url" {
  type    = string
  default = "./iso/Windows_11.iso"
}

variable "memory" {
  type    = string
  default = "4096"
}

variable "vm_name" {
  type    = string
  default = "windows_11"
}

source "hyperv-iso" "hyperv" {
  boot_command                      = ["a<wait>a<wait>a"]
  boot_wait                         = "-1s"
  cd_files                          = [
                                      "./answer_files/11_hyperv/Autounattend.xml",
                                      "./scripts/fixnetwork.ps1",
                                      "./scripts/disable-screensaver.ps1",
                                      "./scripts/disable-winrm.ps1",
                                      "./scripts/enable-winrm.ps1",
                                      "./scripts/microsoft-updates.ps1",
                                      "./scripts/win-updates.ps1"
                                    ]
  communicator                      = "winrm"
  configuration_version             = "10.0"
  cpus                              = "${var.cpus}"
  disk_size                         = "${var.disk_size}"
  enable_dynamic_memory             = false
  enable_mac_spoofing               = true
  enable_secure_boot                = true
  enable_tpm                        = true
  enable_virtualization_extensions  = true
  generation                        = "2"
  guest_additions_mode              = "disable"
  iso_checksum                      = "${var.iso_checksum}"
  iso_url                           = "${var.iso_url}"
  memory                            = "${var.memory}"
  shutdown_command                  = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  switch_name                       = "Default Switch"
  vm_name                           = "${var.vm_name}"
  winrm_password                    = "vagrant"
  winrm_timeout                     = "6h"
  winrm_username                    = "vagrant"
}

source "parallels-iso" "parallels" {
  boot_command                      = ["a<wait>a<wait>a"]
  boot_wait                         = "-1s"
  communicator                      = "winrm"
  cpus                              = "${var.cpus}"
  disk_size                         = "${var.disk_size}"
  floppy_files                      = [
                                      "./answer_files/11_parallels/Autounattend.xml",
                                      "./scripts/fixnetwork.ps1",
                                      "./scripts/disable-screensaver.ps1",
                                      "./scripts/disable-winrm.ps1",
                                      "./scripts/enable-winrm.ps1",
                                      "./scripts/microsoft-updates.ps1",
                                      "./scripts/win-updates.ps1"
                                    ]
  guest_os_type                     = "win-11"
  iso_checksum                      = "${var.iso_checksum}"
  iso_url                           = "${var.iso_url}"
  memory                            = "${var.memory}"
  parallels_tools_flavor            = "win"
  prlctl                            = [["set", "{{ .Name }}", "--efi-secure-boot", "on"], ["set", "{{ .Name }}", "--tpm", "on"]]
  shutdown_command                  = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  vm_name                           = "${var.vm_name}"
  winrm_password                    = "vagrant"
  winrm_timeout                     = "6h"
  winrm_username                    = "vagrant"
}

source "virtualbox-iso" "virtualbox" {
  boot_command                      = ["a<wait>a<wait>a"]
  boot_wait                         = "-1s"
  cd_files                          = [
                                      "./answer_files/11_hyperv/Autounattend.xml",
                                      "./scripts/fixnetwork.ps1",
                                      "./scripts/disable-screensaver.ps1",
                                      "./scripts/disable-winrm.ps1",
                                      "./scripts/enable-winrm.ps1",
                                      "./scripts/microsoft-updates.ps1",
                                      "./scripts/win-updates.ps1"
                                    ]
  communicator                      = "winrm"
  cpus                              = "${var.cpus}"
  disk_size                         = "${var.disk_size}"
  firmware                          = "efi"
  guest_additions_mode              = "disable"
  guest_os_type                     = "Windows11_64"
  headless                          = "${var.headless}"
  iso_checksum                      = "${var.iso_checksum}"
  iso_url                           = "${var.iso_url}"
  memory                            = "${var.memory}"
  shutdown_command                  = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  vm_name                           = "${var.vm_name}"
  winrm_password                    = "vagrant"
  winrm_timeout                     = "6h"
  winrm_username                    = "vagrant"
}

source "vmware-iso" "vmware" {
  boot_command                      = ["a<wait>a<wait>a"]
  boot_wait                         = "-1s"
  cd_files                          = [
                                      "./answer_files/11_bypass/Autounattend.xml",
                                      "./scripts/fixnetwork.ps1",
                                      "./scripts/disable-screensaver.ps1",
                                      "./scripts/disable-winrm.ps1",
                                      "./scripts/enable-winrm.ps1",
                                      "./scripts/microsoft-updates.ps1",
                                      "./scripts/win-updates.ps1"
                                    ]
  communicator                      = "winrm"
  cpus                              = "${var.cpus}"
  disk_adapter_type                 = "lsisas1068"
  disk_size                         = "${var.disk_size}"
  disk_type_id                      = "1"
  guest_os_type                     = "windows9-64"
  headless                          = "${var.headless}"
  iso_checksum                      = "${var.iso_checksum}"
  iso_url                           = "${var.iso_url}"
  memory                            = "${var.memory}"
  shutdown_command                  = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  version                           = "20"
  vm_name                           = "${var.vm_name}"
  vmx_data = {
    "RemoteDisplay.vnc.enabled"     = "false"
    "RemoteDisplay.vnc.port"        = "5900"
    firmware                        = "efi"
  }
  vmx_remove_ethernet_interfaces    = true
  vnc_port_max                      = 5980
  vnc_port_min                      = 5900
  winrm_password                    = "vagrant"
  winrm_timeout                     = "6h"
  winrm_username                    = "vagrant"
}

build {
  sources = [
    "source.hyperv-iso.hyperv",
    "source.parallels-iso.parallels",
    "source.virtualbox-iso.virtualbox",
    "source.vmware-iso.vmware"
  ]

  provisioner "powershell" {
    scripts = [
      "./scripts/vm-guest-tools.ps1"
    ]
  }

  post-processor "vagrant" {
    keep_input_artifact  = false
    output               = "windows_11_{{ .Provider }}.box"
    vagrantfile_template = "vagrantfile-windows_11.template"
  }
}
