---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/index.ts` : null %>"
force: true
---
// add import handler here
export * from './create-<%= struct.name.lowerKebabName %>.handler.generated';
export * from './update-<%= struct.name.lowerKebabName %>.handler.generated';
export * from './delete-<%= struct.name.lowerKebabName %>.handler.generated';
export * from './get-<%= struct.name.lowerKebabName %>.handler.generated';
export * from './search-<%= struct.name.lowerKebabName %>.handler.generated';
export * from './index.extend';

export class handlerManifest {
  package: string;
}
