#
# managed by ansible
#
/var/log/ansible.log
/var/log/ansible-plays.log
/var/log/ansible-pull.log
{
  rotate 14
  daily
  compress
  missingok
  notifempty
}
