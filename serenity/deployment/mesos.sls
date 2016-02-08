# Serenity & Mesos deployment.

{% set build_root = salt['pillar.get']('serenity:build_root', 'salt://serenity/build/mesos_latest') %}

copy_libmesos_so:
  file.managed:
    - name: /opt/serenity/mesos/lib/libmesos.so
    - source: {{ build_root }}/lib/libmesos.so
    - mode: 777
    - makedirs: True

copy_libmesos_la:
  file.managed:
    - name: /opt/serenity/mesos/lib/libmesos.la
    - source: {{ build_root }}/lib/libmesos.la
    - mode: 777
    - makedirs: True

/opt/serenity/mesos/lib/libmesos-0.24.1.so:
  file.symlink:
    - target: /opt/serenity/mesos/lib/libmesos.so
    - force: True

/opt/serenity/mesos/bin:
  file.recurse:
    - source: {{ build_root }}/bin
    - file_mode: 777

/opt/serenity/mesos/sbin:
  file.recurse:
    - source: {{ build_root }}/sbin
    - file_mode: 777
{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
/opt/serenity/mesos/share:
  file.recurse:
    - source: {{ build_root }}/share
    - file_mode: 777

/opt/serenity/mesos/lib:
  file.recurse:
    - source: {{ build_root }}/java/target
    - file_mode: 777
{% else %}
/opt/serenity/mesos/libexec:
  file.recurse:
    - source: {{ build_root }}/libexec
    - file_mode: 777
{% endif %}


