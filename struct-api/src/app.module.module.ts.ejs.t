---
to: <%= rootDirectory %>/api/src/app/app.module.ts
inject: true
skip_if: "<%= struct.name.pascalName %>Module,"
after: "// Add all modules here"
---
    <%= struct.name.pascalName %>Module,