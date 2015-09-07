# Serenity deployment.

{% set serenity_build_root = salt['pillar.get']('serenity:serenity_build_root', 'salt://serenity/build/serenity_latest') %}

{% if 'slave' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
/opt/serenity/mesos/lib/libserenity.so:
  file.managed:
    - source: {{ serenity_build_root }}/libserenity.so
    - makedirs: True
{% endif %}


