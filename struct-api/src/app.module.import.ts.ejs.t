---
to: <%= rootDirectory %>/api/src/app/app.module.ts
inject: true
skip_if: "import { <%= struct.name.pascalName %>Module }"
after: "// Add all modules import here"
---
import { <%= struct.name.pascalName %>Module } from './endpoint/<%= struct.name.lowerKebabName %>/<%= struct.name.lowerKebabName %>.module';