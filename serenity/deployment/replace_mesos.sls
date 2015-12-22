{% set libmesos_path = salt['pillar.get']('serenity:libmesos_path', '/usr/lib') %}
symlink_libmesos1:
  file.symlink:
    - name: {{ libmesos_path }}/libmesos-0.24.1.so
    - target: /opt/serenity/mesos/lib/libmesos.so
    - force: True

symlink_libmesos2:
  file.symlink:
    - name: {{ libmesos_path }}/libmesos.so
    - target: /opt/serenity/mesos/lib/libmesos.so
    - force: True
