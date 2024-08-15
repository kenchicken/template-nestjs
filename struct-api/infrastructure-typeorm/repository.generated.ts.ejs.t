---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/infrastructure/typeorm/${struct.name.lowerKebabName}.repository.generated.ts` : null %>"
force: true
---
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from '../../repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import { Search<%= struct.name.pascalName %>Condition } from 'src/app/repository/condition/generated/search-<%= struct.name.lowerKebabName %>.condition';

export class <%= struct.name.pascalName %>RepositoryGenerated
  implements <%= struct.name.pascalName %>RepositoryInterfaceGenerated
{
  constructor(
    @InjectRepository(<%= struct.name.pascalName %>Entity)
    private <%= struct.name.lowerCamelCase %>Repository: Repository<<%= struct.name.pascalName %>Entity>,
  ) {}

  async create(<%= struct.name.pascalName %>: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity> {
    return await this.<%= struct.name.lowerCamelCase %>Repository.save(new<%= struct.name.pascalName %>);
  }

  async delete(id: number): Promise<void> {
    const <%= struct.name.lowerCamelCase %> = await this.<%= struct.name.lowerCamelCase %>Repository.findOneBy({ id });
    await this.<%= struct.name.lowerCamelCase %>Repository.remove(<%= struct.name.lowerCamelCase %>);
  }

  async get(id: number): Promise<<%= struct.name.pascalName %>Entity> {
    return await this.<%= struct.name.lowerCamelCase %>Repository.findOneBy({ id });
  }

  async update(id: number, item: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity> {
    await this.<%= struct.name.lowerCamelCase %>Repository.save(item);
    return this.<%= struct.name.lowerCamelCase %>Repository.findOneBy({ id });
  }

  async getAll(condition: Search<%= struct.name.pascalName %>Condition): Promise<<%= struct.name.pascalName %>Entity[]> {
    return await this.<%= struct.name.lowerCamelCase %>Repository.find({
      where: {
      <%_ struct.fields.forEach(function (field, key) { -%>
        <%_ if (!field.related) { -%>
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

  async count(condition: Search<%= struct.name.pascalName %>Condition): Promise<number> {
    return await this.<%= struct.name.lowerCamelCase %>Repository.count({
      where: {
      <%_ struct.fields.forEach(function (field, key) { -%>
        <%_ if (!field.related) { -%>
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

  async getAllWithCursor(condition: Search<%= struct.name.pascalName %>Condition): Promise<<%= struct.name.pascalName %>Entity[]> {
    return await this.<%= struct.name.lowerCamelCase %>Repository.find({
      where: {
      <%_ struct.fields.forEach(function (field, key) { -%>
        <%_ if (!field.related) { -%>
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
    });
  }
}
