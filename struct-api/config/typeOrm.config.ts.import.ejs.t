---
to: <%= rootDirectory %>/api/src/app/config/typeOrm.config.ts
inject: true
skip_if: "import <%= struct.name.pascalName %>Entity from '../entity/<%= struct.name.lowerKebabName %>.entity';"
after: "// add import entity"
---
<%_ if (!struct.tags || !struct.tags.includes('no-migration')) { -%>
import <%= struct.name.pascalName %>Entity from '../entity/<%= struct.name.lowerKebabName %>.entity';<%_ } -%>