---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/repository/condition/generated/search-${struct.name.lowerKebabName}.condition.ts` : null %>"
force: true
---
export class Search<%= struct.name.pascalName %>Condition {
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
}
