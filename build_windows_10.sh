#!/bin/bash
packer build --only=$1-iso \
       --var iso_url=./iso/en_windows_10_multiple_editions_version_1703_updated_july_2017_x64_dvd_10925340.iso \
       --var iso_checksum=1486EC12B04D7B44BB6CB7D1D2AE52A94C891A10 \
       --var disk_size=262144 \
       windows_10.json
