# Serenity deployment.

include:
{% if 'slave' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
{% if 'none' in salt['pillar.get']('serenity:mesos_master_service_name', salt['pillar.get']('serenity:mesos_slave_service_name', 'none')) %}
  - serenity.service.mesos.stop
  - serenity.service.serenity_mesos.stop
  - serenity.deployment.serenity
  - serenity.service.serenity_mesos.start
{% else %}

  - serenity.service.custom_mesos.stop
  - serenity.deployment.serenity
  - serenity.service.custom_mesos.start
{% endif %}
{% endif %}



