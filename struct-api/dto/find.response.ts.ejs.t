---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/dto/find-${struct.name.lowerKebabName}.response.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';

export default class Find<%= struct.name.pascalName %>Response extends <%= struct.name.pascalName %>Dto {}
