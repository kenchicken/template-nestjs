---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/infrastructure/typeorm/${struct.name.lowerKebabName}.repository.generated.ts` : null %>"
force: true
---
<%_ let hasRelation = false; -%>
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
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated, <%= struct.name.pascalName %>RelationOptions } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import { Search<%= struct.name.pascalName %>Condition } from 'src/app/repository/condition/generated/search-<%= struct.name.lowerKebabName %>.condition';
import ObjectUtil from '../../util/object-util';

export class <%= struct.name.pascalName %>RepositoryGenerated
  implements <%= struct.name.pascalName %>RepositoryInterfaceGenerated
{
  constructor(
    @InjectRepository(<%= struct.name.pascalName %>Entity)
    private <%= struct.name.lowerCamelName %>Repository: Repository<<%= struct.name.pascalName %>Entity>,
  ) {}

  async create(entity: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity> {
    return await this.<%= struct.name.lowerCamelName %>Repository.save(entity);
  }

  async delete(id: number): Promise<void> {
    const <%= struct.name.lowerCamelName %> = await this.<%= struct.name.lowerCamelName %>Repository.findOneBy({ id });
    await this.<%= struct.name.lowerCamelName %>Repository.remove(<%= struct.name.lowerCamelName %>);
  }

  async get(id: number<%= hasRelation ? `, option?: %{struct.name.pascalName}RelationOptions` : '' %>): Promise<<%= struct.name.pascalName %>Entity> {
    <%_ if (hasRelation) { -%>
    let relations = {};
    if (options) {
      if (options.all) {
        relations = {
        <%_ struct.fields.forEach(function (field, key) { -%>
          <%_ if (field.relatedType === 'OneToMany') { -%>
          <%= field.name.lowerCamelName %>: true;
          <%_ } -%>
          <%_ if (field.relatedType === 'ManyToOne') { -%>
          <%= field.name.lowerCamelName %>: true;
          <%_ } -%>
        <%_ }) -%>
        }
      } else {
        relations = {
        <%_ struct.fields.forEach(function (field, key) { -%>
          <%_ if (field.relatedType === 'OneToMany') { -%>
          <%= field.name.lowerCamelName %>: options.<%= field.name.lowerCamelName %>;
          <%_ } -%>
          <%_ if (field.relatedType === 'ManyToOne') { -%>
          <%= field.name.lowerCamelName %>: options.<%= field.name.lowerCamelName %>;
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
    await this.<%= struct.name.lowerCamelName %>Repository.save(entity);
    return this.<%= struct.name.lowerCamelName %>Repository.findOneBy({ id });
  }

  async getAll(condition: Search<%= struct.name.pascalName %>Condition): Promise<<%= struct.name.pascalName %>Entity[]> {
    const order = ObjectUtil.convertOrdersToMap(condition);
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
      <%_ }) -%>
      },
      take: condition.limit,
      skip: condition.offset,
      order: order,
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
