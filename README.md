# Windows 10 template for Packer
Based on [https://github.com/StefanScherer/packer-windows](https://github.com/StefanScherer/packer-windows)  
which is forked from [https://github.com/joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows)

Prebuilt images here: [https://app.vagrantup.com/baunegaard](https://app.vagrantup.com/baunegaard)

## Setup

### Requires:
* **Windows 10 ISO** - (Drop into ./iso folder)
* **mkisofs.exe** if building Hyper-V (Drop into root folder)

**To use the default settings, execute from repo root:**  
* Windows: `build_windows_10.bat <vm_type>`
* Linux / OSX: `./build_windows_10.sh <vm_type>`

`<vm_type>` Can be either `vmware`, `virtualbox` or `parallels`.  
For Generation 2 Hyper-V run `build_windows_10_hyperv.bat`

## Information:
The following variables can be modified in the build script:  
* `iso_url` - Path to ISO file.
* `iso_checksum` - Checksum of ISO file.
* `disk_size` - Max size in MB of dynamic hard drive file.
* `switch_name` - The virtual switch name. Only available in Hyper-V build script.

The result output will be a box file named: `windows_10_<vm_type>.box`

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
