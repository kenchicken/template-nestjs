---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/dto/delete-${struct.name.lowerKebabName}.request.ts` : null %>"
force: true
---
export default class Delete<%= struct.name.pascalName %>Request {}
