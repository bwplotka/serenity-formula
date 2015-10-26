{% if 'slave' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Start docker.
systemctl stop docker:
  cmd.run

start_docker:
   service.dead:
    - name: docker
    - enable: False
{% endif %}