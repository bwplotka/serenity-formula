#!/usr/bin/python

import sys
import json
import codecs
import urllib.request

EXIHIBITOR_STATUS_URL = 'http://localhost:8181/exhibitor/v1/cluster/status'

if len(sys.argv) != 2:
    print 'Usage: exhibitor_wait.py ZOOKEEPER_CLUSTER_SIZE'
    sys.exit(-1)
cluster_size = int(sys.argv[1])

try:
    response = urllib.request.urlopen(EXIHIBITOR_STATUS_URL)
except urllib.error.URLError:
    print 'Could not get exhibitor status: {}'.format(EXIHIBITOR_STATUS_URL)
    sys.exit(1)
reader = codecs.getreader("utf-8")
data = json.load(reader(response))

serving = 0
leaders = 0
for node in data:
    if node['isLeader']:
        leaders += 1
    if node['description'] == 'serving':
        serving += 1

if serving != cluster_size or leaders != 1:
    print 'Expected {} servers and 1 leader, got {} servers and {} leaders'.format(cluster_size, serving, leaders)
    sys.exit(1)

sys.exit(0)
