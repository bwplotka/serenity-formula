{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Start Marathon.
start_marathon:
  service.running:
    - name: marathon
    #- enable: True
{% endif %}

