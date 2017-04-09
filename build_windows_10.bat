@echo off
packer build --only=%1-iso ^
       --var iso_url=./iso/en_windows_10_multiple_editions_version_1703_updated_march_2017_x64_dvd_10189288.iso ^
       --var iso_checksum=CE8005A659E8DF7FE9B080352CB1C313C3E9ADCE ^
       --var disk_size=262144 ^
       windows_10.json
