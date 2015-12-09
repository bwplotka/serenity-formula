{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Stop custom mesos.
systemctl stop {{ salt['pillar.get']('serenity:mesos_master_service_name', mesos-master) }}:
  cmd.run

stop_custom_mesos:
  service.dead:
    - name: {{ salt['pillar.get']('serenity:mesos_master_service_name', mesos-master) }}
    - enable: False
{% else %}
# Stop custom mesos.
systemctl stop {{ salt['pillar.get']('serenity:mesos_slave_service_name', mesos-slave) }}:
  cmd.run

stop_custom_mesos:
  service.dead:
    - name: {{ salt['pillar.get']('serenity:mesos_slave_service_name', mesos-slave) }}
    - enable: False
{% endif %}

