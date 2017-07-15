#!/bin/bash
packer build --only=$1-iso \
       --var iso_url=./iso/en_windows_10_multiple_editions_version_1703_updated_june_2017_x64_dvd_10725021.iso \
       --var iso_checksum=AB15A9CF175E8F0B8361B2D4F0EA560343B93FBE \
       --var disk_size=262144 \
       windows_10.json
