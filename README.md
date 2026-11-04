# Windows 11 desktop boxes for Packer

[![CI](https://github.com/Baune8D/packer-windows-desktop/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/Baune8D/packer-windows-desktop/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/github/license/Baune8D/packer-windows-desktop)](https://github.com/Baune8D/packer-windows-desktop/blob/main/LICENSE)

A Packer template that builds a Windows 11 desktop Vagrant box from your own ISO, for Hyper-V, Parallels, VirtualBox or VMware. It changes only what Packer and Vagrant need to work, and installs all available Windows updates.

Based on [StefanScherer/packer-windows](https://github.com/StefanScherer/packer-windows), which is forked from [joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows).

Prebuilt boxes, last built in 2022: [baunegaard on the HCP Vagrant Registry](https://portal.cloud.hashicorp.com/vagrant/discover/baunegaard).

## Requirements

- [Packer](https://developer.hashicorp.com/packer/install).
- Hyper-V, Parallels Desktop, VirtualBox, or VMware Workstation Pro or Fusion Pro. The template builds x64 Windows, so it needs an x64 host: Parallels and VMware on Apple silicon can't build it.
- A Windows 11 ISO at `iso/Windows_11.iso`. See [iso/README.md](iso/README.md).
- Except for Parallels, `xorriso`, `mkisofs`, `hdiutil` or `oscdimg` in `PATH`, to create the CD with the answer file and scripts. macOS has `hdiutil`. On Windows, `oscdimg` comes with the [Windows ADK](https://learn.microsoft.com/windows-hardware/get-started/adk-install), or `choco install windows-adk-oscdimg`.

## Build

From the repository root:

```sh
./build_windows_11.sh <provider>    # Linux and macOS
.\build_windows_11.bat <provider>   # Windows
```

`<provider>` is `hyperv`, `parallels`, `virtualbox` or `vmware`. Installing the Windows updates takes a while. The result is `windows_11_<provider>.box`, which you add to Vagrant with:

```sh
vagrant box add windows_11 windows_11_<provider>.box
```

## Settings

Set the variables with `-var name=value`, or with `PKR_VAR_name` environment variables, which also work with the build scripts.

| Variable | Default | Description |
| --- | --- | --- |
| `locale` | `en-US` | Input, system and user locale. The display language stays en-US. |
| `time_zone` | `Pacific Standard Time` | Windows time zone ID. `tzutil /l` lists them. |
| `cpus` | `2` | Number of CPUs during the build. |
| `memory` | `4096` | Memory in MB during the build. |
| `disk_size` | `262144` | Disk size in MB. |
| `headless` | `false` | Build without a console window. VirtualBox and VMware only. |
| `iso_url` | `./iso/Windows_11.iso` | Path or URL of the Windows 11 ISO. |
| `iso_checksum` | `none` | Checksum to verify the ISO with, e.g. `sha256:E239FF...`. |
| `vm_name` | `windows_11` | Name of the VM during the build. |

For example, a box with Danish locale and time zone:

```sh
PKR_VAR_locale=da-DK PKR_VAR_time_zone="Romance Standard Time" ./build_windows_11.sh virtualbox
```

```powershell
$env:PKR_VAR_locale = 'da-DK'; $env:PKR_VAR_time_zone = 'Romance Standard Time'; .\build_windows_11.bat virtualbox
```

The CPUs and memory of the finished box are set in [vagrantfile-windows_11.template](vagrantfile-windows_11.template), and can be changed in your own `Vagrantfile`.

## What the build changes

For Packer and Vagrant to work:

- WinRM is configured and starts automatically.
- The 32-bit and 64-bit PowerShell execution policy is RemoteSigned.
- UAC is disabled.
- Networks are set to private.
- Hibernation and the screensaver are disabled.
- Automatic logon is enabled, with the admin user `vagrant`, password `vagrant`, which doesn't expire.

It also enables Microsoft Update and installs all available Windows updates, and installs the guest tools:

- VMware: the latest VMware Tools from packages.vmware.com.
- VirtualBox: the latest Guest Additions from download.virtualbox.org.
- Parallels: the Parallels Tools of the Parallels Desktop version you build with.
- Hyper-V: none needed.

## License

[MIT](LICENSE)
