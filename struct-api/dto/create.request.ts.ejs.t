---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/dto/create-${struct.name.lowerKebabName}.request.generated.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';

export default class Create<%= struct.name.pascalName %>Request extends <%= struct.name.pascalName %>Dto {
  loginUserID?: number;
}
