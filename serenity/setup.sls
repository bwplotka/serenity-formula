# Setup serenity on new or existing mesos.

include:
{% if 'none' in salt['pillar.get']('serenity:mesos_master_service_name', salt['pillar.get']('serenity:mesos_slave_service_name', 'none')) %}
  - serenity.configure.setup_new_mesos
{% else %}
  - serenity.configure.setup_on_existing_mesos
{% endif %}