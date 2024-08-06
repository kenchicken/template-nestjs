---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/index.ts` : null %>"
force: true
---
export * from './<%= struct.name.lowerKebabName %>.service.generated';
export * from './handler';
export * from './query';
