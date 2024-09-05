---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/dto/model-${struct.name.lowerKebabName}.ts` : null %>"
force: true
---
import Model<%= struct.name.pascalName %>Generated from 'src/app/dto/generated/model-<%= struct.name.lowerKebabName %>.generated';

export default class Model<%= struct.name.pascalName %> extends Model<%= struct.name.pascalName %>Generated {
  loginUserID?: number;
}
