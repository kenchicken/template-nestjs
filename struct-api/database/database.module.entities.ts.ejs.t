---
to: <%= rootDirectory %>/api/src/database/database.module.ts
inject: true
skip_if: "          <%= struct.name.pascalName %>Entity,"
after: "// add entity after here"
---
          <%= struct.name.pascalName %>Entity,