# Serenity & Mesos deployment.

include:
{% if 'none' in salt['pillar.get']('serenity:mesos_master_service_name', salt['pillar.get']('serenity:mesos_slave_service_name', 'none')) %}
  - serenity.service.marathon.stop
  - serenity.service.serenity_marathon.stop
  - serenity.service.serenity_role_marathon.stop
  - serenity.service.mesos.stop
  - serenity.service.serenity_mesos.stop
  - serenity.deployment.serenity
  - serenity.deployment.mesos
  - serenity.service.serenity_mesos.start
  - serenity.service.marathon.start
{% else %}
  - serenity.service.marathon.stop
  - serenity.service.custom_mesos.stop
  - serenity.deployment.serenity
  - serenity.deployment.mesos
  - serenity.deployment.replace_mesos
  - serenity.service.custom_mesos.start
  - serenity.service.marathon.start
{% endif %}

