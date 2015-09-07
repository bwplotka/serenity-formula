{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
# Stop Serenity mesos.
systemctl stop serenity-mesos-master:
  cmd.run

stop_serenity_mesos:
  service.dead:
    - name: serenity-mesos-master
    - enable: False
{% else %}
# Stop  Serenity mesos.
systemctl stop serenity-mesos-slave:
  cmd.run

stop_serenity_mesos:
  service.dead:
    - name: serenity-mesos-slave
    - enable: False
{% endif %}

