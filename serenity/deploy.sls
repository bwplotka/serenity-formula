# Serenity deployment.

include:
  - serenity.service.mesos.stop
  - serenity.service.serenity_mesos.stop
  - serenity.deployment.serenity
  - serenity.service.serenity_mesos.start


