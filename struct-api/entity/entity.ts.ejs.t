---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/entity/${struct.name.lowerKebabName}.entity.ts` : null %>"
force: true
---
<%_ let hasOneToMany = false; -%>
<%_ let hasManyToOne = false; -%>
<%_ let hasOneToOne = false; -%>
<%_ struct.fields.forEach(function (field, key) { -%>
  <%_ if (field.dataType === 'array' && field.structName != null) { -%>
    <%_ joinColumn = true; -%>
  <%_ } -%>
  <%_ if (field.dataType === 'struct' && field.structName != null) { -%>
    <%_ joinColumn = true; -%>
  <%_ } -%>
<%_ }) -%>
<%_ if (hasManyToOne) { -%>
import { ManyToOne } from 'typeorm';
import <%= struct.name.pascalName %> from 'src/app/entity/<%= struct.name.lowerKebabPluralName %>.entity';
<%_ } else if (hasOneToMany) { -%>
import { OneToMany } from 'typeorm';
import <%= struct.name.pascalName %> from 'src/app/entity/<%= struct.name.lowerKebabPluralName %>.entity';
<%_ } else if (hasOneToOne) { -%>
import { OneToOne } from 'typeorm';
import <%= struct.name.pascalName %> from 'src/app/entity/<%= struct.name.lowerKebabPluralName %>.entity';
<%_ } else { -%>
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';
<%_ } -%>

@Entity('<%= struct.name.lowerKebabPluralName %>')
class <%= struct.name.pascalName %> {
<%_ struct.fields.forEach(function (field, key) { -%>
  <%_ if (!field.related) { -%>
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
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
  @Column({ comment: '<%= field.screenLabel %>', nullable: true %> })
  <%_ } else { -%>
  @Column({ comment: '<%= field.screenLabel %>', nullable: false %> })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: string;
    <%_ } -%>
    <%_ if (field.dataType === 'number') { -%>
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
    @Column({ comment: '<%= field.screenLabel %>', nullable: true %> })
  <%_ } else { -%>
    @Column({ comment: '<%= field.screenLabel %>', nullable: false %> })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: number;
    <%_ } -%>
    <%_ if (field.dataType === 'time') { -%>
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
    @Column({ comment: '<%= field.screenLabel %>', nullable: true %> })
  <%_ } else { -%>
    @Column({ comment: '<%= field.screenLabel %>', nullable: false %> })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: Date;
    <%_ } -%>
    <%_ if (field.dataType === 'bool') { -%>
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
    @Column({ comment: '<%= field.screenLabel %>', nullable: true %> })
  <%_ } else { -%>
    @Column({ comment: '<%= field.screenLabel %>', nullable: false %> })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: boolean;
    <%_ } -%>
  <%_ } -%>
  <%_ } else { -%>
    <%_ if (field.dataType === 'array' && field.structName != null) { -%>
  @OneToMany(() => <%= field.structName.pascalName %>,(<%= field.structName.lowerCamelName %>) => <%= field.structName.lowerCamelName %>.<%= struct.name.lowerCamelName %>)
  <%= field.name.lowerCamelName %>?: <%= field.structName.pascalName %>[];
    <%_ } -%>
    <%_ if (field.dataType === 'struct' && field.structName != null) { -%>
  @ManyToOne(() => <%= field.structName.pascalName %>, (<%= field.structName.lowerCamelName %>) => <%= field.structName.lowerCamelName %>)
  <%= field.name.lowerCamelName %>?: <%= field.structName.pascalName %>;
    <%_ } -%>
    <%_ if (field.dataType !== 'struct' && field.dataType !== 'array' && field.structName != null) { -%>
  @OneToOne(() => <%= field.structName.pascalName %>)
  @JoinColumn({ name: "<%= field.structName.lowerSnakeName %>_id" })
  <%= field.name.lowerCamelName %>?: <%= field.structName.pascalName %>;
    <%_ } -%>
<%_ } -%>
<%_ }) -%>
}

export default <%= struct.name.pascalName %>;
