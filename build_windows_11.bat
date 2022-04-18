@echo off
packer build --force ^
  --only=%1-iso ^
  windows_11.json
