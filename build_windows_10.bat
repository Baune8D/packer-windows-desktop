@echo off
packer build --only=%1-iso ^
    --var disk_type_id=3 ^
    --var vhv_enable=true ^
    --var disk_size=262144 ^
    --var iso_url=./iso/en_windows_10_multi-edition_version_1709_updated_nov_2017_x64_dvd_100290211.iso ^
    --var iso_checksum=F6E6B43F931DC41622E8AC107A5E82A3CEC7FC66 ^
    windows_10.json
