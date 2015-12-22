{% set libmesos_path = salt['pillar.get']('serenity:libmesos_path', '/usr/lib') %}
symlink_libmesos1:
  file.symlink:
    - name: /opt/serenity/mesos/lib/libmesos.so
    - target: {{ libmesos_path }}/libmesos-0.24.1.so
    - force: True

symlink_libmesos2:
  file.symlink:
    - name: /opt/serenity/mesos/lib/libmesos.so
    - target: {{ libmesos_path }}/libmesos.so
    - force: True
