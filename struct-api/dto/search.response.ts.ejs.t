---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/dto/generated/model-${struct.name.lowerKebabPluralName}.ts` : null %>"
force: true
---
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';

export default class Model<%= struct.name.pascalPluralName %> {
  <%= struct.name.lowerCamelPluralName %>: <%= struct.name.pascalName %>Dto[];
  count: number;
}
