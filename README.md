# Windows 10 template for Packer
Based on [https://github.com/StefanScherer/packer-windows](https://github.com/StefanScherer/packer-windows)  
which is forked from [https://github.com/joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows)

## **Setup**
**You might need to change the iso url and checksum in the build script!**

### **Requires:**
A Windows 10 Pro ISO - (**MSDN**)  
Packer - [Link](https://www.packer.io/docs/installation.html)

**To use the default settings, execute from repo root:**  
Windows: **build_windows_10.bat <vm_type>**  
Linux / OSX: **./build_windows_10.sh <vm_type>**  
**<vm_type>** Can be either 'vmware', 'virtualbox' or 'parallels'.

## **Information:**
Put your windows ISO into the ./iso/ folder.

The following variables can be modified in the build script:  
**iso_url** - URL to ISO file. (Should be in ./iso/)  
**iso_checksum** - SHA1 checksum of ISO file.  
**disk_size** - Max size in MB of dynamic hard drive file.

The result output will be a box file named: **windows_10_<vm_type>.box**

#### Will set the following settings for Vagrant compatibility:
WinRM service configured and started automatically.  
32 & 64 bit Powershell execution policy set to RemoteSigned.  
UAC disabled.  
Networks set to private.  
Default admin user: vagrant  
Default admin password: vagrant