#!/bin/bash
packer build --only=$1-iso \
    --var disk_size=262144 \
    --var iso_url=./iso/en_windows_10_multi-edition_version_1709_updated_dec_2017_x64_dvd_100406711.iso \
    --var iso_checksum=3EFB9174B7FE997509B89D0FF8CE6BDDC6000C5A \
    windows_10.json
