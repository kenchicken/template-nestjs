---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/dto/update-${struct.name.lowerKebabName}.dto.ts` : null %>"
force: true
---
import { PartialType } from '@nestjs/mapped-types';

export class Update<%= struct.name.pascalName %>Dto {
<%_ struct.fields.forEach(function (field, key) { -%>
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
<%_ }) -%>
}
