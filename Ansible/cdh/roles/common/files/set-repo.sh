#!/bin/bash

set -e

useRepo=
fastestSpeed=0

for repo in http://osmirror.ashb.wandisco.com \
            http://osmirror.shdc.wandisco.com \
            http://10.8.2.208 \
            http://10.6.2.186 \
            http://10.6.60.6 \
            http://10.6.6.6; do
    if ! speed=$(curl -s --connect-timeout 1 --write-out '%{speed_download}' \
                 -o /dev/null $repo 2>/dev/null | sed -e 's/\..*//'); then
      continue;
    fi

    if [[ $speed -gt $fastestSpeed ]]; then
      useRepo=$repo
      fastestSpeed=$speed
    fi
done

echo $useRepo
exit 0
