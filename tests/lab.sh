set -euo pipefail

apt-get update -qq >/dev/null
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq ansible openssh-server >/dev/null
mkdir -p /run/sshd

ansible-playbook -i localhost, -c local -e container_lab=true /work/ansible/playbook.yml
/usr/sbin/sshd -t
/usr/sbin/sshd -T > /tmp/sshd-effective.conf
grep -Fxq 'permitrootlogin no' /tmp/sshd-effective.conf

test "$(stat -c '%a' /etc/modprobe.d/cis.conf)" = '644'
grep -Fxq 'install cramfs /bin/true' /etc/modprobe.d/cis.conf
grep -Fxq 'install freevxfs /bin/true' /etc/modprobe.d/cis.conf
grep -Fxq 'install jffs2 /bin/true' /etc/modprobe.d/cis.conf
test "$(wc -l < /etc/modprobe.d/cis.conf)" -eq 3
echo 'SSH and module configuration checks passed.'

ansible-playbook -i localhost, -c local -e container_lab=true /work/ansible/playbook.yml | tee /tmp/second-run.log
grep -Eq 'changed=0.*failed=0' /tmp/second-run.log
echo 'Second playbook run made no changes.'
