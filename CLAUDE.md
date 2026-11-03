# packer-windows-desktop

A Packer template that builds a Windows 11 desktop Vagrant box for Hyper-V, Parallels, VirtualBox and VMware from a local ISO.

- `windows_11.pkr.hcl`: the template. One source per provider, a PowerShell provisioner for the guest tools and the Vagrant post-processor. Keep the shared settings identical across the sources.
- `answer_files/*/Autounattend.xml.pkrtpl`: the Windows Setup answer files, rendered with `templatefile` (`locale`, `time_zone`) into `cd_content`, or `floppy_content` for Parallels. `11_hyperv` is also used by VirtualBox; `11_bypass` (VMware) skips the TPM and Secure Boot checks.
- `scripts/`: PowerShell run by the answer files during setup (WinRM, network, updates) and by the provisioner (`vm-guest-tools.ps1`). They run in Windows PowerShell 5.1.
- `build_windows_11.sh` / `.bat` run `packer init` and `packer build --only=<provider>-iso.<provider>`. `vagrantfile-windows_11.template` is the box's Vagrantfile.
- The README lists the variables and what the build changes. Keep it in step with the template and the answer files.

## Workflow

- Conventional commits (`feat:`, `fix:`, `chore(deps):`, `ci:`, `build:`, `docs:`), one commit per concern, directly on `main`.
- Only push, tag, publish or edit GitHub releases when asked.
- Commit messages must be accurate. If one turns out to be wrong before it is pushed, reword it (replay the commits and check that the tree is unchanged). Never rewrite pushed history.

## Dependencies

- The Packer plugins are pinned to a major version (`~> 1.1`, not `~> 1`, which allows any later major). Major upgrades are done by hand; check the plugin's release notes for breaking changes.
- The guest tools are downloaded at build time, with a pinned fallback URL in `vm-guest-tools.ps1`. Check that the fallback still resolves when touching that script.
- Dependabot updates the GitHub Actions weekly on Monday with a 7-day cooldown, in one grouped pull request.

## Testing

- CI runs `packer fmt -check`, `packer validate`, `shellcheck build_windows_11.sh` and `Invoke-ScriptAnalyzer -Path . -Recurse -EnableExit`. Run them before committing; keep `packer init` plugins out of the repo with `PACKER_PLUGIN_PATH`.
- The hyperv plugin needs `powershell.exe`, so validate locally with `-except=hyperv-iso.hyperv`; CI validates hyperv on Windows.
- A build needs an x64 host with the hypervisor and takes hours, so there are no automated builds. To check an answer file change, render it with `packer console` (`templatefile(...)`) and diff the output.
