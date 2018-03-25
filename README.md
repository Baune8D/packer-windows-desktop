# Windows 10 template for Packer
Based on [https://github.com/StefanScherer/packer-windows](https://github.com/StefanScherer/packer-windows)  
which is forked from [https://github.com/joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows)

## **Setup**

### **Requires:**
* Windows 10 ISO - (Drop into ./iso folder)
* Packer - (Drop into this folder)

**To use the default settings, execute from repo root:**  
Windows: **build_windows_10.bat <vm_type>**  
Linux / OSX: **./build_windows_10.sh <vm_type>**  
**<vm_type>** Can be either 'vmware', 'virtualbox' or 'parallels'.

## **Information:**
The following variables can be modified in the build script:  
**iso_url** - URL to ISO file. (Should be located in ./iso)  
**iso_checksum** - SHA1 checksum of ISO file.  
**disk_size** - Max size in MB of dynamic hard drive file.

The result output will be a box file named: **windows_10_<vm_type>.box**

#### The script will adjust the following settings for Vagrant compatibility:
WinRM service configured and started automatically.  
32 & 64 bit Powershell execution policy set to RemoteSigned.  
UAC disabled.  
Networks set to private.  
Autologin enabled.  
Default admin user: vagrant  
Default admin password: vagrant