---
to: <%= rootDirectory %>/api/src/config/typeOrm.config.ts
inject: true
skip_if: "import <%= struct.name.pascalName %>Entity from '../entity/<%= struct.name.lowerKebabName %>.entity';"
after: "// add entity after here"
---
import <%= struct.name.pascalName %>Entity from '../entity/<%= struct.name.lowerKebabName %>.entity';
