# Rescue - revert binary to the backed up binary.
# -- NOT TESTED --

{% if 'slave' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
mesos-slave:
  service.dead: []

stop_sereniy_mesos:
  service.dead:
    - name: serenity-mesos-slave

/opt/serenity/mesos/lib/libserenity.so:
  file.copy:
    - source: /opt/serenity/mesos/libserenity.so.backup

start_sereniy_mesos:
  service.running:
    - name: serenity-mesos-slave
{% endif %}
