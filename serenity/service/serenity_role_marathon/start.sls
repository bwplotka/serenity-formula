{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Start Serenity Role Marathon.
start_serenity_role_marathon:
  service.running:
    - name: serenity-role-marathon
    #- enable: True
{% endif %}

