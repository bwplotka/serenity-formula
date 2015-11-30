#!/usr/bin/env bash

MESOS_SERVICE_NAME=$1
# master/slave
MESOS_TYPE=$2

# TODO!
# 1. Get config path from service name (systemctl status MESOS_SERVICE_NAME | grep ..)
# 2. Remove this config(?) and link /opt/serenity/mesos/etc/environment /opt/serenity/mesos/etc/mesos-slave (for slave) /opt/serenity/mesos/etc/mesos-master (for master)
# 3. Return SUCCESS code. (0)