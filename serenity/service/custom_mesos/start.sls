{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
{% set service_name = salt['pillar.get']('serenity:mesos_master_service_name', 'mesos-master') %}
# Start custom mesos.
start_custom_mesos:
  service.running:
    - name: {{ service_name }}
{% else %}
{% set service_name = salt['pillar.get']('serenity:mesos_slave_service_name', 'mesos-slave') %}
# Start custom mesos.
start_custom_mesos:
  service.running:
    - name: {{ service_name }}
{% endif %}

