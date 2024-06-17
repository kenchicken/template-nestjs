---
to: <%= rootDirectory %>/api/src/database/database.module.ts
inject: true
skip_if: "import <%= struct.name.pascalName %>Entity from '../entity/<%= struct.name.lowerKebabName %>.entity';"
after: "// add entity after here"
---
import <%= struct.name.pascalName %>Entity from '../entity/<%= struct.name.lowerKebabName %>.entity';
