#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

DEFAULT_BACKUP_LOCATION="{{ pillar.backup.location }}"

if [ -z "$1" ]; then
  BACKUP_LOCATION=$DEFAULT_BACKUP_LOCATION
else
  BACKUP_LOCATION=$1
fi


rsync -a --delete --mkpath ~/git/salt-workstation/pillar $BACKUP_LOCATION/pillar-data

echo "changed=yes comment='Backup workstation completed'"

