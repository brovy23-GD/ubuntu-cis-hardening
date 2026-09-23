# Ubuntu CIS Hardening

**Ansible-based Ubuntu security-hardening exercise** by [Bobby Rovy](https://github.com/brovy23-GD) | [LinkedIn](https://www.linkedin.com/in/bobbyrovy)

## Overview

This repository demonstrates a small set of Ubuntu hardening tasks inspired by CIS guidance. It is a learning and portfolio project, **not a complete CIS Level 1 or Level 2 implementation or a verified compliance assessment**.

## Implemented in the repository

- Refresh the APT package cache.
- Set `PermitRootLogin no` in `/etc/ssh/sshd_config`, with an SSH service restart handler.
- Write modprobe install overrides for `cramfs`, `freevxfs`, and `jffs2` to `/etc/modprobe.d/cis.conf`.
- Provide an Ansible inventory template and a CI workflow with playbook lint and syntax-check steps.

Source: [Ansible playbook](ansible/playbook.yml) | [Inventory](ansible/inventory.ini) | [CI workflow](.github/workflows/ci.yml)

## Limitations and current status

The current [Python validation tests](tests/test_hardening.py) contain TODOs and `pass` statements. They **do not verify the host's security configuration**. The [scans directory](scans/) contains documentation, not evidence of completed OpenSCAP or Lynis scans. The repository does not establish comprehensive CIS compliance.

The hardening playbook changes system-level SSH and module settings. Review it and verify recovery access before running against a real host; test on a disposable VM or lab environment first.

## Local lab usage

1. Create a disposable Ubuntu VM and confirm console or alternate administrative access.
2. Add the lab host to [`ansible/inventory.ini`](ansible/inventory.ini).
3. Review the playbook's tasks and apply only settings that match your environment.
4. Run `ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --check --diff` to preview changes where supported.
5. If appropriate for the lab, run `ansible-playbook -i ansible/inventory.ini ansible/playbook.yml`.
6. Verify SSH access and configuration independently. **Do not rely on the placeholder Python tests as a security check.**

## Development roadmap

- Implement real host-state validation checks and corresponding meaningful tests.
- Add safe rollback and environment-specific preflight checks.
- Record reproducible scan outputs and map implemented settings to a specific benchmark version.
- Expand hardening tasks only after lab testing.

**Contact:** [LinkedIn](https://www.linkedin.com/in/bobbyrovy)
