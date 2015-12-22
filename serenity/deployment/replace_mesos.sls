{% set libmesos_path = salt['pillar.get']('serenity:mesos_master_service_name', 'mesos-master') %}
/opt/serenity/mesos/lib/libmesos.so:
  file.symlink:
    - target: {{ libmesos_path }}/libmesos-0.24.1.so
    - force: True

/opt/serenity/mesos/lib/libmesos.so:
  file.symlink:
    - target: {{ libmesos_path }}/libmesos.so
    - force: True
