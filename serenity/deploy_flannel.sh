#!/bin/bash
#This script was tested for CentOS 7
#For flannel to work you have to have working etcd cluster and /coreos.com/network/config key in it
set -e
set -o pipefail

#substitute those values
ETCD_ENDPOINTS=${ETCD_ENDPOINT:-http://localhost:2379}
FLANNEL_INTERFACE=${FLANNEL_INTERFACE:-eth0}
VERSION=${VERSION:-0.5.5}

cd /opt
wget https://github.com/coreos/flannel/releases/download/v$VERSION/flannel-$VERSION-linux-amd64.tar.gz
tar -xvzf flannel-$VERSION-linux-amd64.tar.gz
rm -rf flannel-$VERSION-linux-amd64.tar.gz
mv flannel-$VERSION flannel
mkdir -p /run/flannel
touch /run/flannel/docker

/usr/bin/cat << EOF > "/usr/lib/systemd/system/flanneld.service"
[Unit]
Description=Flanneld overlay address etcd agent
After=network.target
Before=docker.service

[Service]
Type=notify
EnvironmentFile=/etc/sysconfig/flanneld
EnvironmentFile=-/etc/sysconfig/docker-network
ExecStart=/opt/flannel/flanneld -etcd-endpoints=\${FLANNEL_ETCD} -etcd-prefix=\${FLANNEL_ETCD_KEY} \$FLANNEL_OPTIONS
ExecStartPost=/opt/flannel/mk-docker-opts.sh -k \$DOCKER_NETWORK_OPTIONS -d /run/flannel/docker

[Install]
RequiredBy=docker.service
EOF

/usr/bin/cat << EOF > "/etc/sysconfig/flanneld"
# Flanneld configuration options

# etcd url location.  Point this to the server where etcd runs
FLANNEL_ETCD="$ETCD_ENDPOINTS"

# etcd config key.  This is the configuration key that flannel queries
# For address range assignment
FLANNEL_ETCD_KEY="/coreos.com/network"

# Any additional options that you want to pass
FLANNEL_OPTIONS="--iface=$FLANNEL_INTERFACE"
EOF

systemctl daemon-reload
systemctl start flanneld

