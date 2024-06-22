---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/infrastructure/typeorm/${struct.name.lowerKebabName}.repository.generated.ts` : null %>"
force: true
---
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerSnakeName %>.entity';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from '../../repository/user.repository.interface.generated';
import { Search<%= struct.name.pascalName %>Dto } from '../../module/user/dto/search-user.dto';

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

  async getAll(condition: Search<%= struct.name.pascalName %>Dto): Promise<<%= struct.name.pascalName %>Entity[]> {
    return await this.<%= struct.name.lowerSnakeName %>Repository.find({
      where: {
      <%_ struct.fields.forEach(function (field, key) { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
      <%_ }) -%>
      },
    });
  }

  async count(condition: Search<%= struct.name.pascalName %>Dto): Promise<number> {
    return await this.<%= struct.name.lowerSnakeName %>Repository.count({
      where: {
      <%_ struct.fields.forEach(function (field, key) { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
      <%_ }) -%>
      },
    });
  }

  async getAllWithCursor(condition: Search<%= struct.name.pascalName %>Dto): Promise<<%= struct.name.pascalName %>Entity[]> {
    return await this.<%= struct.name.lowerSnakeName %>Repository.find({
      where: {
      <%_ struct.fields.forEach(function (field, key) { -%>
        <%= field.name.lowerCamelName %>: condition.<%= field.name.lowerCamelName %>,
      <%_ }) -%>
      },
      take: condition.limit,
      skip: condition.offset,
    });
  }
}
