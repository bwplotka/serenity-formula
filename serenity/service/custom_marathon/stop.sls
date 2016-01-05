{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
{% set service_name = salt['pillar.get']('serenity:marathon_service_name', 'marathon') %}
# Stop custom marathon.
systemctl stop {{ service_name }}:
  cmd.run

stop_custom_marathon:
  service.dead:
    - name: {{ service_name }}
{% endif %}

