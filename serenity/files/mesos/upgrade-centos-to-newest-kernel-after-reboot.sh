#!/usr/bin/env bash

uname -a

# Upgrade required packages
yum -y update --skip-broken

# Upgrade perf
yum -y --enablerepo=elrepo-kernel upgrade perf