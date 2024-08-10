---
to: <%= rootDirectory %>/api/src/database/database.module.ts
inject: true
skip_if: "import <%= struct.name.pascalName %>Entity from '../entity/<%= struct.name.lowerKebabName %>.entity';"
after: "// add import after here"
---
<%_ if (!struct.tags || !struct.tags.includes('no-migration')) { -%>
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
<%_ } -%>