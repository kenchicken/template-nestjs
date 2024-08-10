---
to: <%= rootDirectory %>/.templat_ignore
force: true
---
.templat_ignore
.templat_not_generate

# migration
/api/src/database/migrations/

# extended class
/api/src/app/endpoint/**/controller/*.controller.ts
/api/src/app/endpoint/**/service/handler/index.extend.ts
/api/src/app/endpoint/**/service/handler/*.handler.ts
/api/src/app/endpoint/**/service/query/*.ts
/api/src/app/endpoint/**/dto/*.ts
/api/src/app/repository/*.interface.ts
/api/src/app/share/*.ts
/api/src/app/infrastructure/typeorm/*.repository.ts

# add or updated file
