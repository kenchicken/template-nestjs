---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/dto/generated/search-${struct.name.lowerKebabName}.condition.generated.ts` : null %>"
force: true
---
export default class Search<%= struct.name.pascalName %>ConditionGenerated {
<%_ struct.fields.forEach(function (field, key) { -%>
<%_ if (!field.relatedType) { -%>
<%_ if (field.dataType === 'string') { -%>
  <%= field.name.lowerCamelName %>?: string;
<%_ } -%>
<%_ if (field.dataType === 'number') { -%>
  <%= field.name.lowerCamelName %>?: number;
<%_ } -%>
<%_ if (field.dataType === 'time') { -%>
  <%= field.name.lowerCamelName %>?: Date;
<%_ } -%>
<%_ if (field.dataType === 'bool') { -%>
  <%= field.name.lowerCamelName %>?: boolean;
<%_ } -%>
<%_ } -%>
<%_ }) -%>
  limit?: number;
  offset?: number;
  orderBy?: string;
  loginUserID?: number;
}