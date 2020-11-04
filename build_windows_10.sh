#!/bin/bash
./packer build --only=$1-iso \
    --var disk_size=262144 \
    --var iso_url=./iso/Win10_20H2_English_x64.iso \
    --var iso_checksum=sha256:E793F3C94D075B1AA710EC8D462CEE77FDE82CAF400D143D68036F72C12D9A7E \
    windows_10.json
