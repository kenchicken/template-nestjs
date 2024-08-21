---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/dto/create-${struct.name.lowerKebabName}.request.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= structName.lowerKebabName %>.dto';

export default class Create<%= struct.name.pascalName %>Request extends <%= struct.name.pascalName %>Dto {}
