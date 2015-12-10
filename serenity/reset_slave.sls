# Reset meta of slave (needed when changed configuration too much!)
# Beware: That will couse to deattach all you workloads from Mesos.

{% if 'slave' in salt['grains.get']('mesos-roles', salt['grains.get']('dcos-roles', [])) %}

rm -f /var/lib/mesos/slave/meta/slaves/latest:
  cmd.run

{% endif %}
