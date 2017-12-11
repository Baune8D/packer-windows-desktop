@echo off
packer build --only=%1-iso ^
    --var disk_size=262144 ^
    --var iso_url=./iso/en_windows_10_multi-edition_version_1709_updated_nov_2017_x64_dvd_100290211.iso ^
    --var iso_checksum=1F958B6A80A542C82EECD918126F665AA7381D34 ^
    windows_10.json
