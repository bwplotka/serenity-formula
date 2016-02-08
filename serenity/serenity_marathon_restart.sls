# Marathon restart

include:
  - serenity.service.marathon.stop
  - serenity.service.serenity_marathon.stop
  - serenity.service.serenity_role_marathon.stop
  - serenity.service.serenity_marathon.start
  - serenity.service.serenity_role_marathon.start
