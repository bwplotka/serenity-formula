{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Start Serenity mesos.
start_serenity_mesos:
  service.running:
    - name: serenity-mesos-master
    #- enable: True
{% else %}
# Start Serenity mesos.
start_serenity_mesos:
  service.running:
    - name: serenity-mesos-slave
    #- enable: True
{% endif %}

