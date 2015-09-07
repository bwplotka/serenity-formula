{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Stop Serenity Marathon.
stop_serenity_marathon:
  service.dead:
    - name: serenity-marathon
    - enable: False
{% endif %}

