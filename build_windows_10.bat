@echo off
packer build --only=%1-iso ^
    --var disk_size=262144 ^
    --var iso_url=./iso/en_windows_10_multi-edition_version_1709_updated_dec_2017_x64_dvd_100406711.iso ^
    --var iso_checksum=EA214EE684A5BB8230707104C54A3B74D92F1D69 ^
    windows_10.json
