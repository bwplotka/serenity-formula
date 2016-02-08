{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
{% set service_name = salt['pillar.get']('serenity:mesos_master_service_name', 'mesos-master') %}
# Stop custom mesos.
systemctl stop {{ service_name }}:
  cmd.run

stop_custom_mesos:
  service.dead:
    - name: {{ service_name }}
{% else %}
{% set service_name = salt['pillar.get']('serenity:mesos_slave_service_name', 'mesos-slave') %}
# Stop custom mesos.
systemctl stop {{ service_name }}:
  cmd.run

stop_custom_mesos:
  service.dead:
    - name: {{ service_name }}
{% endif %}

