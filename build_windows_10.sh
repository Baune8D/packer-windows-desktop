#!/bin/bash
packer build --only=$1-iso \
       --var iso_url=./iso/en_windows_10_multiple_editions_version_1607_updated_jan_2017_x64_dvd_9714399.iso \
       --var iso_checksum=44064680647ee4c877a6f54739ad82759147c828 \
       --var disk_size=184320 \
       windows_10.json
