
# Make sure that every is able to match hostnames.
/etc/hosts:
  file.managed:
    - source: salt://serenity/files/hosts
