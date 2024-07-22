---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/entity/${struct.name.lowerKebabName}.entity.ts` : null %>"
force: true
---
<%_ let joinColumn = false; -%>
<%_ struct.fields.forEach(function (field, key) { -%>
  <%_ if (field.dataType === 'array' && field.structName != null) { -%>
    <%_ joinColumn = true; -%>
  <%_ } -%>
<%_ }) -%>
<%_ if (joinColumn) { -%>
import { Entity, Column, JoinColumn, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import <%= struct.name.pascalName %> from 'src/app/entity/<%= struct.name.lowerKebabPluralName %>.entity';
<%_ } else { -%>
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';
<%_ } -%>

@Entity('<%= struct.name.lowerKebabPluralName %>')
class <%= struct.name.pascalName %> {
<%_ struct.fields.forEach(function (field, key) { -%>
  <%_ if (field.name.lowerCamelName === 'id') { -%>
    <%_ if (field.dataType === 'string') { -%>
  @PrimaryGeneratedColumn()
  <%= field.name.lowerCamelName %>?: string;
    <%_ } -%>
    <%_ if (field.dataType === 'number') { -%>
  @PrimaryGeneratedColumn()
  <%= field.name.lowerCamelName %>?: number;
    <%_ } -%>
  <%_ } -%>
  <%_ if (field.name.lowerCamelName !== 'id') { -%>
    <%_ if (field.dataType === 'string') { -%>
  @Column()
  <%= field.name.lowerCamelName %>?: string;
    <%_ } -%>
    <%_ if (field.dataType === 'number') { -%>
  @Column()
  <%= field.name.lowerCamelName %>?: number;
    <%_ } -%>
    <%_ if (field.dataType === 'time') { -%>
  @Column()
  <%= field.name.lowerCamelName %>?: Date;
    <%_ } -%>
    <%_ if (field.dataType === 'bool') { -%>
  @Column()
  <%= field.name.lowerCamelName %>?: boolean;
    <%_ } -%>
    <%_ if (field.dataType === 'array' && field.structName != null) { -%>
  @OneToMany(() => <%= field.structName.pascalName %>,(<%= field.structName.lowerCamelName %>) => <%= field.structName.lowerCamelName %>.<%= struct.name.lowerCamelName %>)
  <%= field.name.lowerCamelName %>?: <%= field.structName.pascalName %>[];
    <%_ } -%>
    <%_ if (field.dataType !== 'array' && field.structName != null) { -%>
  @ManyToOne(() => <%= field.structName.pascalName %>, (<%= field.structName.lowerCamelName %>) => <%= field.structName.lowerCamelName %>)
  <%= field.name.lowerCamelName %>?: <%= field.structName.pascalName %>;
    <%_ } -%>
  <%_ if (field.dataType !== 'struct' && field.structName != null) { -%>
  @OneToOne(() => <%= field.structName.pascalName %>)
  @JoinColumn({ name: "<%= field.structName.lowerSnakeName %>_id" })
  <%= field.name.lowerCamelName %>?: <%= field.structName.pascalName %>;
<%_ } -%>
  <%_ } -%>
<%_ }) -%>
}

export default <%= struct.name.pascalName %>;
