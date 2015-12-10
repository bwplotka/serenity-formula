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

# Deploy LD PATH:
/etc/ld.so.conf.d/mesos.conf:
  file.symlink:
    - target: /opt/serenity/mesos/etc/mesos.conf

# Deploy systemd configuration using symlinks:
/etc/systemd/system/serenity.target:
  file.symlink:
    - target: /opt/serenity/mesos/etc/systemd/system/serenity.target

{% if 'master' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}
/etc/systemd/system/serenity-mesos-master.service:
  file.symlink:
    - target: /opt/serenity/mesos/etc/systemd/system/serenity.target.wants/serenity-mesos-master.service
    - makedirs: True
/etc/systemd/system/serenity-marathon.service:
  file.symlink:
    - target: /opt/serenity/mesos/etc/systemd/system/serenity.target.wants/serenity-marathon.service
    - makedirs: True
/etc/systemd/system/serenity-role-marathon.service:
  file.symlink:
    - target: /opt/serenity/mesos/etc/systemd/system/serenity.target.wants/serenity-role-marathon.service
    - makedirs: True

# Take some time. (.jar)
/opt/serenity/marathon:
  file.recurse:
    - source: salt://serenity/files/marathon
    - include_empty: True
    - file_mode: 777

{% else %}
perf:
  pkg.installed

/etc/systemd/system/serenity-mesos-slave.service:
  file.symlink:
    - target: /opt/serenity/mesos/etc/systemd/system/serenity.target.wants/serenity-mesos-slave.service
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
