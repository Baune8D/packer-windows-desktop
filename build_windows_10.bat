@echo off
packer build --only=%1-iso ^
    --var disk_size=262144 ^
    --var iso_url=./iso/en_windows_10_consumer_edition_version_1803_updated_jul_2018_x64_dvd_12712603.iso ^
    --var iso_checksum=24D91524EBFC963FE428DDCAE78CB17D978B2E3F ^
    windows_10.json
