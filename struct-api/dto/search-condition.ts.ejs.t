---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/dto/search-${struct.name.lowerKebabName}.condition.ts` : null %>"
force: true
---
import Search<%= struct.name.pascalName %>ConditionGenerated from 'src/app/dto/search-<%= struct.name.lowerKebabName %>.condition.generated';

export default class Search<%= struct.name.pascalName %>Condition extends Search<%= struct.name.pascalName %>ConditionGenerated {
}
