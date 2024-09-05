---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/dto/search-${struct.name.lowerKebabName}.condition.ts` : null %>"
force: true
---
import Model<%= struct.name.pascalName %>Generated from 'src/app/dto/model-<%= struct.name.lowerKebabName %>.generated';

export default class Search<%= struct.name.pascalName %>Condition extends Search<%= struct.name.pascalName %>ConditionGenerated {
}
