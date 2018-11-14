#!/bin/bash
./packer build --only=$1-iso \
    --var disk_size=262144 \
    --var iso_url=./iso/Win10_1809Oct_English_x64.iso \
    --var iso_checksum=BEE211937F3ED11606590B541B2F5B97237AC09D \
    windows_10.json
