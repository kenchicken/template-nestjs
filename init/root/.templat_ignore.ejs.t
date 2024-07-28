---
to: <%= rootDirectory %>/.templat_ignore
force: true
---
# migration
/api/src/database/migrations/

# extended class
/api/src/app/module/**/controller/*.controller.ts
/api/src/app/module/**/service/handler/*.ts
/api/src/app/module/**/dto/*.ts
/api/src/app/repository/*.interface.ts
/api/src/app/infrastructure/typeorm/*.repository.ts

# not use api
/api/src/app/module/attachment/
/api/src/app/module/attachment-event/
/api/src/app/module/attachment-recurring-event/
/api/src/app/module/event-member-type/
/api/src/app/module/event-user/
