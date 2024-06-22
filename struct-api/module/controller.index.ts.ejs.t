---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/controller/index.ts` : null %>"
force: true
---
export * from './<%= struct.name.lowerKebabName %>.controller.generated';
export * from './<%= struct.name.lowerKebabName %>.controller';
