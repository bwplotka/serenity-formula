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

# TODO(bplotka): For Daniel: Create such script.
# Run script for appending serenity config to existing Mesos cluster(TODO!)
{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
append_config:
  cmd.script:
    - source: salt://serenity/scripts/append_config.sh
    - user: root
    - group: root
    - shell: /bin/bash
    - args salt['pillar.get']('serenity:mesos_master_service_name', mesos-master) salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])

{% else %}
append_config:
  cmd.script:
    - source: salt://serenity/scripts/append_config.sh
    - user: root
    - group: root
    - shell: /bin/bash
    - args salt['pillar.get']('serenity:mesos_slave_service_name', mesos-slave) salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])

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
