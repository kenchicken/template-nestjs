---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/infrastructure/database/${struct.name.lowerKebabName}.repository.generated.ts` : null %>"
force: true
---
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import <%= struct.name.pascalName %>Entity from 'src/entity/<%= struct.name.lowerSnakeName %>.entity';

export class <%= struct.name.pascalName %>RepositoryGenerated implements <%= struct.name.pascalName %>RepositoryInterfaceGenerated {
  constructor(
    @InjectRepository(<%= struct.name.pascalName %>Entity)
    private <%= struct.name.lowerSnakeName %>Repository: Repository<<%= struct.name.pascalName %>Entity>
  ) {}

  async create(<%= struct.name.lowerSnakeName %>: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity> {
    const new<%= struct.name.pascalName %> = this.<%= struct.name.lowerSnakeName %>Repository.create(<%= struct.name.lowerSnakeName %>)
    return await this.<%= struct.name.lowerSnakeName %>Repository.save(new<%= struct.name.pascalName %>)
  }

  async delete(id: number): Promise<void> {
    const <%= struct.name.lowerSnakeName %> = await this.<%= struct.name.lowerSnakeName %>Repository.findOneBy({id})
    await this.<%= struct.name.lowerSnakeName %>Repository.remove(<%= struct.name.lowerSnakeName %>)
  }

  async get(id: number): Promise<<%= struct.name.pascalName %>Entity> {
    return await this.<%= struct.name.lowerSnakeName %>Repository.findOneBy({id})
  }

  async getMulti(ids: number[]): Promise<<%= struct.name.pascalName %>Entity> {
    return Promise.resolve(undefined)
  }

  async update(id: number, item: <%= struct.name.pascalName %>Entity): Promise<<%= struct.name.pascalName %>Entity> {
    await this.<%= struct.name.lowerSnakeName %>Repository.update(id, item)
    return this.<%= struct.name.lowerSnakeName %>Repository.findOneBy({id})
  }

  async getAll(condition: <%= struct.name.pascalName %>SearchCondition): Promise<<%= struct.name.pascalName %>Entity[]> {
    return await this.<%= struct.name.lowerSnakeName %>Repository.find({
      where: {
        email: condition.email,
      },
      take: condition.limit,
      skip: condition.offset
    });
  }

  count(condition: <%= struct.name.pascalName %>SearchCondition): Promise<number> {
    return Promise.resolve(0);
  }

  getAllWithCursor(condition: <%= struct.name.pascalName %>SearchCondition): Promise<<%= struct.name.pascalName %>Entity[]> {
    return Promise.resolve([]);
  }

}