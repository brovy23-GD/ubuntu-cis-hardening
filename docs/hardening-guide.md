# Ubuntu hardening lab guide

## Scope

This project applies three tasks: refresh the APT cache, set `PermitRootLogin no`, and write modprobe install overrides for `cramfs`, `freevxfs`, and `jffs2`. It is a small exercise inspired by CIS guidance, not a complete CIS benchmark implementation or compliance assessment.

## Verified container lab

From the repository root in PowerShell, with Docker Desktop running:

```powershell
docker run --rm -v "$((Get-Location).Path):/work:ro" ubuntu:22.04 bash /work/tests/lab.sh

```

The script installs Ansible and OpenSSH inside a disposable Ubuntu 22.04 container. It applies the playbook locally with `container_lab=true`, checks SSH syntax and the effective `permitrootlogin no` setting, verifies the three modprobe lines and file mode, then runs the playbook again to check that it makes no changes.

The lab flag skips the SSH service restart because the container has no normal service manager. A restart on a regular Ubuntu server has not been tested by this container lab. The lab verifies the modprobe configuration file, not whether a particular kernel module is loaded or available.

## Applying to a separate Ubuntu lab host

Review `ansible/playbook.yml` and confirm console or alternate administrative access before changing SSH settings. Add only a disposable lab host to `ansible/inventory.local.ini`; this file is ignored by Git.

Preview the playbook where check mode is supported:

```bash
ansible-playbook -i ansible/inventory.local.ini ansible/playbook.yml --check --diff
```

Apply it only after reviewing the preview and your recovery access:

```bash
ansible-playbook -i ansible/inventory.local.ini ansible/playbook.yml
```

Without `container_lab=true`, a changed SSH setting notifies the restart handler. Verify effective SSH settings and connectivity on the lab host after applying.

## Limits

No real host deployment, OpenSCAP or Lynis scan, benchmark mapping, or comprehensive CIS compliance has been verified.
