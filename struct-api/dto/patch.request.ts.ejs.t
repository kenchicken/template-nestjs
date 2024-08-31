---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/dto/generated/patch-${struct.name.lowerKebabName}.request.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';

export default class Patch<%= struct.name.pascalName %>Request extends <%= struct.name.pascalName %>Dto {
  loginUserID?: number;
}