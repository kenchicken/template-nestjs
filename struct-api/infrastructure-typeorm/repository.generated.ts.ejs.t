---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/infrastructure/typeorm/${struct.name.lowerKebabName}.repository.generated.ts` : null %>"
force: true
---
<%_ let hasRelation = false; -%>
<%_ let getOptionStr = ''; -%>
<%_ struct.fields.forEach(function (field, key) { -%>
  <%_ if (field.relatedType === 'OneToMany') { -%>
    <%_ hasRelation = true; -%>
  <%_ } -%>
  <%_ if (field.relatedType === 'OneToOne') { -%>
    <%_ hasRelation = true; -%>
  <%_ } -%>
  <%_ if (field.relatedType === 'ManyToOne') { -%>
    <%_ hasRelation = true; -%>
  <%_ } -%>
<%_ }) -%>
<%_ -%>
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated, <%= struct.name.pascalName %>RelationOptions } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import Search<%= struct.name.pascalName %>Condition from 'src/app/dto/search-<%= struct.name.lowerKebabName %>.condition';
import ObjectUtil from '../../util/object-util';

export class <%= struct.name.pascalName %>RepositoryGenerated
  implements <%= struct.name.pascalName %>RepositoryInterfaceGenerated
{
  constructor(
    @InjectRepository(<%= struct.name.pascalName %>Entity)
    private <%= struct.name.lowerCamelName %>Repository: Repository<<%= struct.name.pascalName %>Entity>,
  ) {}

  async create(entity: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity> {
    entity.createdAt = new Date();
    entity.updatedAt = new Date();
    return await this.<%= struct.name.lowerCamelName %>Repository.save(entity);
  }

  async delete(id: number): Promise<void> {
    if (!id) {
      return null;
    }
    const <%= struct.name.lowerCamelName %> = await this.<%= struct.name.lowerCamelName %>Repository.findOneBy({ id });
    <%_ struct.fields.forEach(function (field, key) { -%>
      <%_ if (field.relatedType === 'OneToMany' && field.dbTags.indexOf('->;') === -1) { -%>
    <%= struct.name.lowerCamelName %>.<%= field.name.lowerCamelName %> = [];
      <%_ } -%>
      <%_ if (field.relatedType === 'ManyToOne' && field.dbTags.indexOf('->;') === -1) { -%>
    <%= struct.name.lowerCamelName %>.<%= field.name.lowerCamelName %> = null;
      <%_ } -%>
    <%_ }) -%>
    await this.<%= struct.name.lowerCamelName %>Repository.save(<%= struct.name.lowerCamelName %>);
    await this.<%= struct.name.lowerCamelName %>Repository.remove(<%= struct.name.lowerCamelName %>);
  }

  <%_ if (hasRelation) { -%>
  async get(id: number, options?: <%= struct.name.pascalName %>RelationOptions): Promise<<%= struct.name.pascalName %>Entity> {
  <%_ } else { -%>
  async get(id: number): Promise<<%= struct.name.pascalName %>Entity> {
  <%_ } -%>
    if (!id) {
      return null;
    }
    <%_ if (hasRelation) { -%>
    let relations = {};
    if (options) {
      if (options.all) {
        relations = {
        <%_ struct.fields.forEach(function (field, key) { -%>
          <%_ if (field.relatedType === 'OneToMany' && field.dbTags.indexOf('->;') === -1) { -%>
          <%= field.name.lowerCamelName %>: true,
          <%_ } -%>
          <%_ if (field.relatedType === 'ManyToOne' && field.dbTags.indexOf('->;') === -1) { -%>
          <%= field.relatedStructName.lowerCamelName %>: true,
          <%_ } -%>
        <%_ }) -%>
        };
      } else {
        relations = {
        <%_ struct.fields.forEach(function (field, key) { -%>
          <%_ if (field.relatedType === 'OneToMany' && field.dbTags.indexOf('->;') === -1) { -%>
          <%= field.name.lowerCamelName %>: options.<%= field.name.lowerCamelName %>,
          <%_ } -%>
          <%_ if (field.relatedType === 'ManyToOne' && field.dbTags.indexOf('->;') === -1) { -%>
          <%= field.relatedStructName.lowerCamelName %>: options.<%= field.relatedStructName.lowerCamelName %>,
          <%_ } -%>
        <%_ }) -%>
        };
      }
    }
    <%_ } -%>
    return await this.<%= struct.name.lowerCamelName %>Repository.findOne({
      where: { id },
    <%_ if (hasRelation) { -%>
      relations: relations,
    <%_ } -%>
    });
  }

  async update(id: number, entity: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity> {
    if (!id) {
      return null;
    }
    entity.updatedAt = new Date();
    await this.<%= struct.name.lowerCamelName %>Repository.save(entity);
  <%_ if (hasRelation) { -%>
    return this.get(id, { all: true });
  <%_ } else { -%>
    return this.get(id);
  <%_ } -%>
  }

  <%_ if (hasRelation) { -%>
  async getAll(condition: Search<%= struct.name.pascalName %>Condition, options?: <%= struct.name.pascalName %>RelationOptions): Promise<<%= struct.name.pascalName %>Entity[]> {
  <%_ } else { -%>
  async getAll(condition: Search<%= struct.name.pascalName %>Condition): Promise<<%= struct.name.pascalName %>Entity[]> {
  <%_ } -%>
    const order = ObjectUtil.convertOrdersToMap(condition);
    <%_ if (hasRelation) { -%>
    let relations = {};
    if (options) {
      if (options.all) {
        relations = {
        <%_ struct.fields.forEach(function (field, key) { -%>
          <%_ if (field.relatedType === 'OneToMany' && field.dbTags.indexOf('->;') === -1) { -%>
          <%= field.name.lowerCamelName %>: true,
          <%_ } -%>
          <%_ if (field.relatedType === 'ManyToOne' && field.dbTags.indexOf('->;') === -1) { -%>
          <%= field.relatedStructName.lowerCamelName %>: true,
          <%_ } -%>
        <%_ }) -%>
        };
      } else {
        relations = {
        <%_ struct.fields.forEach(function (field, key) { -%>
          <%_ if (field.relatedType === 'OneToMany' && field.dbTags.indexOf('->;') === -1) { -%>
          <%= field.name.lowerCamelName %>: options.<%= field.name.lowerCamelName %>,
          <%_ } -%>
          <%_ if (field.relatedType === 'ManyToOne' && field.dbTags.indexOf('->;') === -1) { -%>
          <%= field.relatedStructName.lowerCamelName %>: options.<%= field.relatedStructName.lowerCamelName %>,
          <%_ } -%>
        <%_ }) -%>
        };
      }
    }
    <%_ } -%>
    return await this.<%= struct.name.lowerCamelName %>Repository.find({
      where: {
      <%_ struct.fields.forEach(function (field, key) { -%>
        <%_ if (!field.relatedType) { -%>
        <%_ if (field.dataType === 'string') { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
        <%_ } -%>
        <%_ if (field.dataType === 'number') { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
        <%_ } -%>
        <%_ if (field.dataType === 'time') { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
        <%_ } -%>
        <%_ if (field.dataType === 'bool') { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
        <%_ } -%>
        <%_ } -%>
        <%_ if (field.relatedType === 'ManyToOne') { -%>
        <%= field.relatedStructName.lowerCamelName %>: { id: condition.<%= field.name.lowerCamelName %> },
        <%_ } -%>
      <%_ }) -%>
      },
      take: condition.limit,
      skip: condition.offset,
      order: order,
    <%_ if (hasRelation) { -%>
      relations: relations,
    <%_ } -%>
    });
  }

  async count(condition: Search<%= struct.name.pascalName %>Condition): Promise<number> {
    return await this.<%= struct.name.lowerCamelName %>Repository.count({
      where: {
      <%_ struct.fields.forEach(function (field, key) { -%>
        <%_ if (!field.relatedType) { -%>
        <%_ if (field.dataType === 'string') { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
        <%_ } -%>
        <%_ if (field.dataType === 'number') { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
        <%_ } -%>
        <%_ if (field.dataType === 'time') { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
        <%_ } -%>
        <%_ if (field.dataType === 'bool') { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
        <%_ } -%>
        <%_ } -%>
      <%_ }) -%>
      },
    });
  }
}
