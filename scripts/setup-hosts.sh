#!/bin/bash
set -e
IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# remove ubuntu-jammy entry
sed -e '/^.*ubuntu-jammy.*/d' -i /etc/hosts

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
10.0.0.11  master-1
10.0.0.12  master-2
10.0.0.13  master-3
10.0.0.21  worker-1
10.0.0.22  worker-2
10.0.0.23  worker-2
10.0.0.30  lb
EOF
