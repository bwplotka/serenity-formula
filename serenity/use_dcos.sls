# Make sure that dcos's standard mesos services are running.

include:
  - serenity.service.serenity_marathon.stop
  - serenity.service.marathon.stop
  - serenity.service.mesos.stop
  - serenity.service.serenity_mesos.stop
  - serenity.service.mesos.start
  - serenity.service.marathon.start