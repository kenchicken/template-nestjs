---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/dto/search-${struct.name.lowerKebabName}.request.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= structName.lowerKebabName %>.dto';

export default class Search<%= struct.name.pascalName %>Response extends <%= struct.name.pascalName %>Dto {}
