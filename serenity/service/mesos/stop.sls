{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Stop DCOS mesos.
systemctl stop mesos-master:
  cmd.run

stop_dcos_mesos:
  service.dead:
    - name: mesos-master
    - enable: False
{% else %}
# Stop DCOS mesos.
systemctl stop mesos-slave:
  cmd.run

stop_dcos_mesos:
  service.dead:
    - name: mesos-slave
    - enable: False
{% endif %}

