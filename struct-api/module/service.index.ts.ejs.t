---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/service/index.ts` : null %>"
force: true
---
export * from './<%= struct.name.lowerKebabName %>.service.generated';
export * from './handler';
