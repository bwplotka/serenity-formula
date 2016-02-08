{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Start DCOS mesos.
start_dcos_mesos:
  service.running:
    - name: mesos-master
    #- enable: True
{% else %}
# Start DCOS mesos.
start_dcos_mesos:
  service.running:
    - name: mesos-slave
    #- enable: True
{% endif %}

