# Ubuntu CIS Hardening Guide

## Overview
This project automates Ubuntu server hardening based on CIS (Center for Internet Security) benchmarks.

## Prerequisites
- Ansible 2.9+
- Target Ubuntu 20.04 or 22.04 servers
- SSH access with sudo privileges

## Quick Start

### 1. Update inventory
Edit \nsible/inventory.ini\ with your target servers.

### 2. Run the playbook
\\\ash
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
\\\

### 3. Verify hardening
\\\ash
python tests/test_hardening.py
\\\

## CIS Controls Implemented
- [ ] 1.1.1 Disable unused filesystems
- [ ] 5.2.2 Disable SSH root login
- [ ] 5.2.3 Configure SSH idle timeout
- [ ] 6.1.1 Audit system file permissions

## Scanning
Run OpenSCAP or Lynis for compliance verification.
