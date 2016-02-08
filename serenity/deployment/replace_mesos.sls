{% set libmesos_path = salt['pillar.get']('serenity:libmesos_path', '/usr/lib') %}
{% set mesos_version = salt['pillar.get']('serenity:mesos:version', '0.27.0') %}

symlink_libmesos1:
  file.symlink:
    - name: {{ libmesos_path }}/libmesos-{{ mesos_version}}.so
    - target: /opt/serenity/mesos/lib/libmesos.so
    - force: True

symlink_libmesos2:
  file.symlink:
    - name: {{ libmesos_path }}/libmesos.so
    - target: /opt/serenity/mesos/lib/libmesos.so
    - force: True

symlink_libmesos3:
  file.symlink:
    - name: {{ libmesos_path }}/libmesos.la
    - target: /opt/serenity/mesos/lib/libmesos.la
    - force: True

{% set mesos_slave_bin_path = salt['pillar.get']('serenity:mesos_slave_bin_path', '/bin') %}

# Backup original content.
backup_mesos_slave_bin1:
  file.copy:
    - name: {{ mesos_slave_bin_path }}/mesos-slave.backup
    - source: {{ mesos_slave_bin_path }}/mesos-slave

symlink_mesos_slave_bin1:
  file.symlink:
    - name: {{ mesos_slave_bin_path }}/mesos-slave
    - target: /opt/serenity/mesos/sbin/mesos-slave
    - force: True
