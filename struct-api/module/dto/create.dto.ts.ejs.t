---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/dto/generated/create-${struct.name.lowerKebabName}.dto.ts` : null %>"
force: true
---
import { ApiProperty } from '@nestjs/swagger';

export class Create<%= struct.name.pascalName %>Dto {
<%_ struct.fields.forEach(function (field, key) { -%>
<%_ if (field.dataType === 'string') { -%>
  @ApiProperty()
  <%= field.name.lowerCamelName %>?: string;
<%_ } -%>
<%_ if (field.dataType === 'number') { -%>
  @ApiProperty()
  <%= field.name.lowerCamelName %>?: number;
<%_ } -%>
<%_ if (field.dataType === 'time') { -%>
  @ApiProperty()
  <%= field.name.lowerCamelName %>?: Date;
<%_ } -%>
<%_ if (field.dataType === 'bool') { -%>
  @ApiProperty()
  <%= field.name.lowerCamelName %>?: boolean;
<%_ } -%>
<%_ }) -%>
}
