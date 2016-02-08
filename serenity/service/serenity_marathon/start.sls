{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Start Serenity Marathon.
start_serenity_marathon:
  service.running:
    - name: serenity-marathon
    #- enable: True
{% endif %}

