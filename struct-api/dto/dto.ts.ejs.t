---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/dto/${struct.name.lowerKebabName}.dto.ts` : null %>"
force: true
---
<%_ let hasOneToMany = false; -%>
<%_ let hasOneToOne = false; -%>
<%_ let importStructs = []; -%>
<%_ let importStructNames = []; -%>
<%_ struct.fields.forEach(function (field, key) { -%>
  <%_ if (field.relatedType === 'OneToMany') { -%>
    <%_ hasOneToMany = true; -%>
    <%_ if (!importStructNames.includes(field.structName.pascalName)) { -%>
      <%_ importStructs.push(field.structName); -%>
      <%_ importStructNames.push(field.structName.pascalName); -%>
    <%_ } -%>
  <%_ } -%>
  <%_ if (field.relatedType === 'OneToOne') { -%>
    <%_ hasOneToOne = true; -%>
    <%_ if (!importStructNames.includes(field.relatedStructName.pascalName)) { -%>
      <%_ importStructs.push(field.relatedStructName); -%>
      <%_ importStructNames.push(field.relatedStructName.pascalName); -%>
    <%_ } -%>
  <%_ } -%>
<%_ }) -%>
import { ApiProperty } from '@nestjs/swagger';
<%_ importStructs.forEach(function (structName, key) { -%>
import <%= structName.pascalName %>Dto from './<%= structName.lowerKebabName %>.dto';
<%_ }) -%>

export default class <%= struct.name.pascalName %>Dto {
<%_ struct.fields.forEach(function (field, key) { -%>
  <%_ if (field.name.lowerCamelName === 'id') { -%>
    <%_ if (field.dataType === 'string') { -%>
  <%= field.name.lowerCamelName %>?: string;
    <%_ } -%>
    <%_ if (field.dataType === 'number') { -%>
  <%= field.name.lowerCamelName %>?: number;
    <%_ } -%>
  <%_ } -%>
  <%_ if (field.name.lowerCamelName !== 'id') { -%>
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
    <%_ if (field.relatedType === 'OneToMany') { -%>
  @ApiProperty({ type: <%= field.structName.pascalName %>Dto[] })
  <%= field.name.lowerCamelName %>?: <%= field.structName.pascalName %>Dto[];
    <%_ } -%>
    <%_ if (field.relatedType === 'OneToOne') { -%>
  @ApiProperty({ type: <%= field.structName.pascalName %>Dto })
  <%= field.relatedStructName.lowerCamelName %>?: <%= field.relatedStructName.pascalName %>Dto;
    <%_ } -%>
  <%_ } -%>
<%_ }) -%>
}
