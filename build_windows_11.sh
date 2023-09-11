#!/bin/bash
packer init windows_11.pkr.hcl
packer build --force \
  --only=$1-iso.$1 \
  windows_11.pkr.hcl
