@echo off
packer build --only=hyperv-iso ^
    --var switch_name="Default Switch" ^
    --var disk_size=262144 ^
    --var iso_url=./iso/Windows.iso ^
    --var iso_checksum=sha256:DDF91DF5BDF2230446EB77A959B7555C59D79F6BC7C622F7E16D31A9BA34A5BF ^
    windows_10.json
