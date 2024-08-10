---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/index.ts` : null %>"
force: true
---
// add import handler here
<%_ if (!struct.excludeGenerateAPI.create) { -%>
export * from './create-<%= struct.name.lowerKebabName %>.handler.generated';
<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.update) { -%>
export * from './update-<%= struct.name.lowerKebabName %>.handler.generated';
<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.delete) { -%>
export * from './delete-<%= struct.name.lowerKebabName %>.handler.generated';
<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.get) { -%>
export * from './get-<%= struct.name.lowerKebabName %>.handler.generated';
<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.search) { -%>
export * from './search-<%= struct.name.lowerKebabName %>.handler.generated';
<%_ } -%>
export * from './index.extend';

export class handlerManifest {
  package: string;
}
