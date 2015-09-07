# Serenity & Mesos deployment.

{% set build_root = salt['pillar.get']('serenity:build_root', 'salt://serenity/build/mesos_latest') %}

# Copy mesos (WARNING: Could be a long running job!)
/opt/serenity/mesos/lib/libmesos-0.24.0.so:
  file.managed:
    - source: {{ build_root }}/lib/libmesos-0.24.0.so
    - mode: 777
    - makedirs: True

/opt/serenity/mesos/lib/libmesos.so:
  file.symlink:
    - target: /opt/serenity/mesos/lib/libmesos-0.24.0.so
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


