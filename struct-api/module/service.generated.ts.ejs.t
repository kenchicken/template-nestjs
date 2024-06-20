---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/service/${struct.name.lowerKebabName}.service.generated.ts` : null %>"
force: true
---
import {Inject, Injectable} from '@nestjs/common';
import { Create<%= struct.name.pascalName %>Dto } from './dto/create-<%= struct.name.lowerKebabName %>.dto';
import { Update<%= struct.name.pascalName %>Dto } from './dto/update-<%= struct.name.lowerKebabName %>.dto';
import { Search<%= struct.name.pascalName %>Dto } from './dto/search-<%= struct.name.lowerKebabName %>.dto';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from "../../entity/<%= struct.name.lowerKebabName %>.entity";

@Injectable()
export class <%= struct.name.pascalName %>ServiceGenerated {
  constructor(
    @Inject('repository')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterface,
  ) {}

  async create(create<%= struct.name.pascalName %>Dto: Create<%= struct.name.pascalName %>Dto): Promise<<%= struct.name.pascalName %>Entity> {
    const new<%= struct.name.pascalName %> = await this.<%= struct.name.lowerCamelName %>Repository.create({
      email: create<%= struct.name.pascalName %>Dto.email,
      firstName: create<%= struct.name.pascalName %>Dto.firstName,
      lastName: create<%= struct.name.pascalName %>Dto.lastName,
      isActive: create<%= struct.name.pascalName %>Dto.isActive,
    });
    await this.<%= struct.name.lowerCamelName %>Repository.save(new<%= struct.name.pascalName %>);
    return new<%= struct.name.pascalName %>;
  }

  }
  async findAll(condition: <%= struct.name.pascalName %>SearchCondition) {
    return this.<%= struct.name.lowerCamelName %>Repository.getAll(condition);
  }

  async findOneById(id: number) {
    return await this.<%= struct.name.lowerCamelName %>Repository.get(id);
  }

  update(id: number, update<%= struct.name.pascalName %>Dto: Update<%= struct.name.pascalName %>Dto) {
    return await this..<%= struct.name.lowerCamelName %>Repository.update(id, {
      <%_ struct.fields.forEach(function (field, key) { -%>
        <%= field.name.lowerCamelName %>?: update<%= struct.name.pascalName %>Dto.<%= field.name.lowerCamelName %>,
      <%_ }) -%>
    });
  }

  remove(id: number) {
    return await this..<%= struct.name.lowerCamelName %>Repository.delete(id);
  }
}