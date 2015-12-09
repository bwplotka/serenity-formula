{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Start custom mesos.
start_custom_mesos:
  service.running:
    - name: {{ salt['pillar.get']('serenity:mesos_master_service_name', 'mesos-master') }}
    #- enable: True
{% else %}
# Start custom mesos.
start_custom_mesos:
  service.running:
    - name: {{ salt['pillar.get']('serenity:mesos_slave_service_name', 'mesos-slave') }}
    #- enable: True
{% endif %}

