---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/dto/generated/create-${struct.name.lowerKebabName}.request.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';

export default class Model<%= struct.name.pascalName %> extends <%= struct.name.pascalName %>Dto {
  loginUserID?: number;
}
