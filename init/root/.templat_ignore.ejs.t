---
to: <%= rootDirectory %>/.templat_ignore
force: true
---
.templat_ignore

# migration
/api/src/database/migrations/

# extended class
/api/src/app/module/**/controller/*.controller.ts
/api/src/app/module/**/service/handler/*.ts
/api/src/app/module/**/dto/*.ts
/api/src/app/repository/*.interface.ts
/api/src/app/infrastructure/typeorm/*.repository.ts

# not use api

