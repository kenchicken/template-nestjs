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
import { OneToOne } from 'typeorm';
<%_ } -%>
<%_ if (hasOneToOne || hasManyToOne || hasOneToMany) { -%>
import { JoinColumn } from 'typeorm';
<%_ } -%>
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';
<%_ importStructs.forEach(function (structName, key) { -%>
import <%= structName.pascalName %>Entity from './<%= structName.lowerKebabName %>.entity';
<%_ }) -%>

@Entity('<%= struct.name.lowerSnakePluralName %>')
class <%= struct.name.pascalName %>Entity {
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
    <%_ if (field.dataType === 'string' && field.relatedType !== 'ManyToOne' && field.relatedType !== 'OneToOne') { -%>
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
  @Column({ name: '<%= field.name.lowerSnakeName %>', comment: '<%= field.screenLabel %>', nullable: false })
  <%_ } else { -%>
  @Column({ name: '<%= field.name.lowerSnakeName %>', comment: '<%= field.screenLabel %>', nullable: true })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: string;

    <%_ } -%>
    <%_ if (field.dataType === 'number' && field.relatedType !== 'ManyToOne' && field.relatedType !== 'OneToOne') { -%>
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
  @Column({ name: '<%= field.name.lowerSnakeName %>', comment: '<%= field.screenLabel %>', nullable: false })
  <%_ } else { -%>
  @Column({ name: '<%= field.name.lowerSnakeName %>', comment: '<%= field.screenLabel %>', nullable: true })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: number;

    <%_ } -%>
    <%_ if (field.dataType === 'time') { -%>
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
  @Column({ name: '<%= field.name.lowerSnakeName %>', comment: '<%= field.screenLabel %>', nullable: false })
  <%_ } else { -%>
  @Column({ name: '<%= field.name.lowerSnakeName %>', comment: '<%= field.screenLabel %>', nullable: true })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: Date;

    <%_ } -%>
    <%_ if (field.dataType === 'bool') { -%>
  <%_ if (field.validateTags && field.validateTags.includes('required')) { -%>
  @Column({ name: '<%= field.name.lowerSnakeName %>', comment: '<%= field.screenLabel %>', nullable: false })
  <%_ } else { -%>
  @Column({ name: '<%= field.name.lowerSnakeName %>', comment: '<%= field.screenLabel %>', nullable: true })
  <%_ } -%>
  <%= field.name.lowerCamelName %>?: boolean;

    <%_ } -%>
  <%_ } -%>
    <%_ if (field.relatedType === 'OneToMany') { -%>
  @OneToMany(
    () => <%= field.structName.pascalName %>Entity,
    (<%= field.structName.lowerCamelName %>) => <%= field.structName.lowerCamelName %>.<%= struct.name.lowerCamelName %>,
    {
      cascade: true,
      createForeignKeyConstraints: false,
    },
  )
  <%= field.name.lowerCamelName %>?: <%= field.structName.pascalName %>Entity[];

    <%_ } -%>
    <%_ if (field.relatedType === 'ManyToOne') { -%>
  @ManyToOne(
    () => <%= field.relatedStructName.pascalName %>Entity,
    (<%= field.relatedStructName.lowerCamelName %>) => <%= field.relatedStructName.lowerCamelName %>.<%= struct.name.lowerCamelPluralName %>,
    {
      orphanedRowAction: 'delete',
      createForeignKeyConstraints: false,
    },
  )
  @JoinColumn({
    name: '<%= field.name.lowerSnakeName %>',
    referencedColumnName: 'id',
  })
  <%= field.relatedStructName.lowerCamelName %>?: <%= field.relatedStructName.pascalName %>Entity;

    <%_ } -%>
    <%_ if (field.relatedType === 'OneToOne') { -%>
  @OneToOne(
    () => <%= field.relatedStructName.pascalName %>Entity,
    {
      cascade: true,
      orphanedRowAction: 'delete',
    },
  )
  @JoinColumn({
    name: '<%= field.name.lowerSnakeName %>',
    referencedColumnName: 'id',
  })
  <%= field.relatedStructName.lowerCamelName %>?: <%= field.relatedStructName.pascalName %>Entity;

    <%_ } -%>
<%_ }) -%>
  @Column({ name: 'created_at', comment: 'Created At', nullable: false })
  createdAt?: Date;

  @Column({ name: 'updated_at', comment: 'Updated At', nullable: false })
  updatedAt?: Date;
}

export default <%= struct.name.pascalName %>Entity;
