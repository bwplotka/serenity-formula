# Deploy service file and confs for mesos
/opt/serenity/mesos:
  file.recurse:
    - source: salt://serenity/files/mesos
    - include_empty: True
    - template: jinja
    - file_mode: 777

# Deploy serenity.json
/opt/serenity/serenity.json.in:
  file.managed:
    - source: salt://serenity/files/serenity.json.in
    - template: jinja

{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
{% set conf_file = salt['pillar.get']('serenity:master_conf_path', /etc/mesos/mesos-master) %}
{{ conf_file }}.backup:
  file.copy:
    - source: {{ conf_file }}

{{ conf_file }}:
  file.symlink:
    - target: /opt/serenity/mesos/etc/mesos-master
    - makedirs: True

{% else %}
{% set conf_file = salt['pillar.get']('serenity:slave_conf_path', /etc/mesos/mesos-master) %}
{{ conf_file }}.backup:
  file.copy:
    - source: {{ conf_file }}

{{ conf_file }}:
  file.symlink:
    - target: /opt/serenity/mesos/etc/mesos-slave
    - makedirs: True

/etc/security/limits.conf:
  file.managed:
    - source: salt://serenity/files/mesos/etc/security/limits.conf

/etc/sysconfig/docker:
  file.managed:
    - source: salt://serenity/files/docker/etc/sysconfig/docker
    - template: jinja

{% endif %}

systemctl daemon-reload:
  cmd.run
