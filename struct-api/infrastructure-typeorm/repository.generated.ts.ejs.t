---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/infrastructure/typeorm/${struct.name.lowerKebabName}.repository.generated.ts` : null %>"
force: true
---
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from '../../repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';

export class <%= struct.name.pascalName %>RepositoryGenerated
  implements <%= struct.name.pascalName %>RepositoryInterfaceGenerated
{
  constructor(
    @InjectRepository(<%= struct.name.pascalName %>Entity)
    private <%= struct.name.lowerSnakeName %>Repository: Repository<<%= struct.name.pascalName %>Entity>,
  ) {}

  async create(<%= struct.name.lowerSnakeName %>: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity> {
    const new<%= struct.name.pascalName %> = this.<%= struct.name.lowerSnakeName %>Repository.create(<%= struct.name.lowerSnakeName %>);
    return await this.<%= struct.name.lowerSnakeName %>Repository.save(new<%= struct.name.pascalName %>);
  }

  async delete(id: number): Promise<void> {
    const <%= struct.name.lowerSnakeName %> = await this.<%= struct.name.lowerSnakeName %>Repository.findOneBy({ id });
    await this.<%= struct.name.lowerSnakeName %>Repository.remove(<%= struct.name.lowerSnakeName %>);
  }

  async get(id: number): Promise<<%= struct.name.pascalName %>Entity> {
    return await this.<%= struct.name.lowerSnakeName %>Repository.findOneById(id);
  }

  async update(id: number, item: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity> {
    await this.<%= struct.name.lowerSnakeName %>Repository.update(id, item);
    return this.<%= struct.name.lowerSnakeName %>Repository.findOneById(id);
  }

  async getAll(condition: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity[]> {
    return await this.<%= struct.name.lowerSnakeName %>Repository.find({
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

  async count(condition: <%= struct.name.pascalName %>Entity): Promise<number> {
    return await this.<%= struct.name.lowerSnakeName %>Repository.count({
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

  async getAllWithCursor(condition:<%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity[]> {
    return await this.<%= struct.name.lowerSnakeName %>Repository.find({
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
