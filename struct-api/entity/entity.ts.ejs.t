---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/entity/${struct.name.lowerKebabName}.entity.ts` : null %>"
force: true
---
<%_ let hasOneToMany = false; -%>
<%_ let hasOneToOne = false; -%>
<%_ let hasManyToOne = false; -%>
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
  <%_ if (field.relatedType === 'ManyToOne') { -%>
    <%_ hasManyToOne = true; -%>
    <%_ if (!importStructNames.includes(field.relatedStructName.pascalName)) { -%>
      <%_ importStructs.push(field.relatedStructName); -%>
      <%_ importStructNames.push(field.relatedStructName.pascalName); -%>
    <%_ } -%>
  <%_ } -%>
<%_ }) -%>
<%_ if (hasManyToOne) { -%>
import { ManyToOne } from 'typeorm';
<%_ } -%>
<%_ if (hasOneToMany) { -%>
import { OneToMany } from 'typeorm';
<%_ } -%>
<%_ if (hasOneToOne) { -%>
import { OneToOne, JoinColumn } from 'typeorm';
<%_ } -%>
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';
<%_ importStructs.forEach(function (structName, key) { -%>
import <%= structName.pascalName %> from 'src/app/entity/<%= structName.lowerKebabName %>.entity';
<%_ }) -%>

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
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
  @Column({ comment: '<%= field.screenLabel %>', nullable: false })
  <%_ } else { -%>
  @Column({ comment: '<%= field.screenLabel %>', nullable: true })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: string;
    <%_ } -%>
    <%_ if (field.dataType === 'number') { -%>
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
  @Column({ comment: '<%= field.screenLabel %>', nullable: false })
  <%_ } else { -%>
  @Column({ comment: '<%= field.screenLabel %>', nullable: true })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: number;
    <%_ } -%>
    <%_ if (field.dataType === 'time') { -%>
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
  @Column({ comment: '<%= field.screenLabel %>', nullable: false })
  <%_ } else { -%>
  @Column({ comment: '<%= field.screenLabel %>', nullable: true })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: Date;
    <%_ } -%>
    <%_ if (field.dataType === 'bool') { -%>
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
  @Column({ comment: '<%= field.screenLabel %>', nullable: false })
  <%_ } else { -%>
  @Column({ comment: '<%= field.screenLabel %>', nullable: true })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: boolean;
    <%_ } -%>
  <%_ } -%>
    <%_ if (field.relatedType === 'OneToMany') { -%>
  @OneToMany(() => <%= field.structName.pascalName %>, (<%= field.structName.lowerCamelName %>) => <%= field.structName.lowerCamelName %>.<%= struct.name.lowerCamelName %>)
  <%= field.name.lowerCamelName %>?: <%= field.structName.pascalName %>[];
    <%_ } -%>
    <%_ if (field.relatedType === 'ManyToOne') { -%>
  @ManyToOne(() => <%= field.relatedStructName.pascalName %>, (<%= field.relatedStructName.lowerCamelName %>) => <%= field.relatedStructName.lowerCamelName %>.<%= struct.name.lowerCamelPluralName %>)
  <%= field.relatedStructName.lowerCamelName %>?: <%= field.relatedStructName.pascalName %>;
    <%_ } -%>
    <%_ if (field.relatedType === 'OneToOne') { -%>
  @OneToOne(() => <%= field.structName.pascalName %>)
  @JoinColumn()
  <%= field.name.lowerCamelName %>?: <%= field.structName.pascalName %>;
    <%_ } -%>
<%_ }) -%>
}

export default <%= struct.name.pascalName %>;
