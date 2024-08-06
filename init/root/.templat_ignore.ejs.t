---
to: <%= rootDirectory %>/.templat_ignore
force: true
---
.templat_ignore

# migration
/api/src/database/migrations/

# extended class
/api/src/app/endpoint/**/controller/*.controller.ts
/api/src/app/endpoint/**/service/handler/*.ts
/api/src/app/endpoint/**/dto/*.ts
/api/src/app/repository/*.interface.ts
/api/src/app/infrastructure/typeorm/*.repository.ts

# not use api

