{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Stop Marathon.
systemctl stop marathon:
  cmd.run

stop_marathon:
  service.dead:
    - name: marathon
    - enable: False
{% endif %}