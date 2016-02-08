# Propagate the file with env variables.

/etc/profile.d/serenity.sh:
  file.managed:
    - source: salt://serenity/files/serenity.env
    - template: jinja