![Ubuntu CIS Hardening Banner](uBUNTU%20gIT%20BANNER.png)

# Ubuntu CIS Hardening

**Ansible-based Ubuntu security-hardening exercise** by [Bobby Rovy](https://github.com/brovy23-GD) | [LinkedIn](https://www.linkedin.com/in/bobbyrovy)

## What this project does

The playbook refreshes the APT cache, sets `PermitRootLogin no` in the SSH configuration, and writes modprobe install overrides for `cramfs`, `freevxfs`, and `jffs2`. It creates `/etc/modprobe.d` if needed and sets the configuration file mode to `0644`.

This is a small exercise inspired by CIS guidance. It does not implement a complete CIS benchmark or establish compliance.

## Verified Ubuntu lab

The playbook was applied in a disposable Ubuntu 22.04 Docker container. The lab checked SSH configuration syntax and the effective `permitrootlogin no` setting, verified the three modprobe lines and file mode, and confirmed that a second playbook run made no changes.

From the repository root in PowerShell, with Docker Desktop running:

```powershell
docker run --rm -v "$((Get-Location).Path):/work:ro" ubuntu:22.04 bash /work/tests/lab.sh
```

The container lab sets `container_lab=true` to skip restarting SSH because it has no normal service manager. A regular Ubuntu server restart has not been verified by this lab.

## Automated checks

GitHub Actions runs Ansible Lint, an Ansible syntax check, and the disposable Ubuntu lab test on pushes and pull requests. See [the workflow](.github/workflows/ci.yml) and [the lab script](tests/lab.sh).

## Limits and next steps

No real server deployment, kernel module runtime check, OpenSCAP or Lynis scan, or full CIS compliance assessment has been completed. Review the [hardening guide](docs/hardening-guide.md) before using the playbook on a separate lab host. The inventory contains no live servers.

**Contact:** [LinkedIn](https://www.linkedin.com/in/bobbyrovy)
