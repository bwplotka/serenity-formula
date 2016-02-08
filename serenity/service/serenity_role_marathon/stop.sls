{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Stop Serenity Role Marathon.
stop_serenity_role_marathon:
  service.dead:
    - name: serenity-role-marathon
    - enable: False
{% endif %}

