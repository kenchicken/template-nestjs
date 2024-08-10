---
to: <%= rootDirectory %>/api/src/database/database.module.ts
inject: true
skip_if: "<%= struct.name.pascalName %>Entity,"
after: "// add entity after here"
---
<%_ if (struct.tags && struct.tags.includes('no-migration')) { -%>
          <%= struct.name.pascalName %>Entity,
<%_ } -%>