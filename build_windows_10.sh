#!/bin/bash
./packer build --only=$1-iso \
    --var disk_size=262144 \
    --var iso_url=./iso/en_windows_10_business_editions_version_1803_updated_march_2018_x64_dvd_12063333.iso \
    --var iso_checksum=28681742FE850AA4BFC7075811C5244B61D462CF \
    windows_10.json
