# Windows 11 Desktop Templates For Packer
Based on [https://github.com/StefanScherer/packer-windows](https://github.com/StefanScherer/packer-windows)  
which is forked from [https://github.com/joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows)

Prebuilt images can be found here: [https://app.vagrantup.com/baunegaard](https://app.vagrantup.com/baunegaard)

This repository aims at creating Windows desktop boxes with a minimum of changes.  
It will only change what is necessary for `vagrant` and `packer` to properly work.

## Setup

### Requires:
* **Windows 11 ISO** in `iso` folder: [See instructions](iso/README.md)

**To use the default settings, execute from repo root:**  
* Windows: `.\build_windows_11.bat <vm_type>`
* Linux / macOS: `./build_windows_11.sh <vm_type>`

`<vm_type>` Can be either `vmware`, `virtualbox`, `parallels` or `hyperv`.

**NOTE** `parallels` is currently not available for `Windows 11`. It will come later.

## Information:
Settings can be modified in the `windows_11.json` files.  
Shared variables can be found at the bottom of the file.

**NOTE** if you want to validate a checksum against your iso, change `iso_checksum` to match your iso file, e.g. `sha256:E239FF...`

The result output will be a box file named: `windows_11_<vm_type>.box`

Newest availble guest tools will be fetched and installed for `VMware` and `Virtualbox`.  
For `Parallels`, the guest tools of the version you are building with is installed.

Microsoft updates are enabled and all available Windows updates will be installed on setup.

#### The script will adjust the following settings for Vagrant compatibility:
* WinRM service configured and started automatically.  
* 32 & 64 bit Powershell execution policy set to RemoteSigned.  
* UAC disabled.  
* Networks set to private.  
* Hibernation disabled.  
* Screensaver disabled.  
* Automatic logon enabled.  
* Default admin user: vagrant  
* Default admin password: vagrant
