{% if 'slave' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Start docker.
start_docker:
  service.running:
    - name: docker
    #- enable: True
{% endif %}

