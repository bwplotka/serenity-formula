{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
{% set service_name = salt['pillar.get']('serenity:marathon_service_name', 'marathon') %}
# Start custom marathon.
start_custom_marathon:
  service.running:
    - name: {{ service_name }}
{% endif %}
