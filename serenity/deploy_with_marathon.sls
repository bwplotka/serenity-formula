# Serenity & Mesos deployment.

include:
  - serenity.service.marathon.stop
  - serenity.service.serenity_marathon.stop
  - serenity.service.mesos.stop
  - serenity.service.serenity_mesos.stop
  - serenity.deployment.serenity
  - serenity.deployment.mesos
  - serenity.service.serenity_mesos.start
  - serenity.service.serenity_marathon.start
