---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/entity/${struct.name.lowerKebabName}.entity.ts` : null %>"
force: true
---
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity('<%= ${struct.name.lowerKebabPluralName} %>')
class <%= struct.name.pascalName %> {
<%_ struct.fields.forEach(function (field, key) { -%>
  <%_ if (field.name.lowerCamelName === 'id') { -%>
    <%_ if (field.dataType === 'string') { -%>
  @PrimaryGeneratedColumn()
  <%= field.name.lowerCamelName %>?: string
    <%_ } -%>
    <%_ if (field.dataType === 'number') { -%>
  @PrimaryGeneratedColumn()
  <%= field.name.lowerCamelName %>?: number
    <%_ } -%>
  <%_ } -%>
  <%_ if (field.name.lowerCamelName !== 'id') { -%>
    <%_ if (field.dataType === 'string') { -%>
  @Column()
  <%= field.name.lowerCamelName %>?: string
    <%_ } -%>
    <%_ if (field.dataType === 'number') { -%>
  @Column()
  <%= field.name.lowerCamelName %>?: number
    <%_ } -%>
    <%_ if (field.dataType === 'time') { -%>
  @Column()
  <%= field.name.lowerCamelName %>?: Date
    <%_ } -%>
    <%_ if (field.dataType === 'bool') { -%>
  @Column()
  <%= field.name.lowerCamelName %>?: boolean
    <%_ } -%>
  <%_ } -%>
<%_ }) -%>
}

export default <%= struct.name.pascalName %>;
