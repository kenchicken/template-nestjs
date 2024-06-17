---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/module/${struct.name.lowerKebabName}/service/${struct.name.lowerKebabName}.service.ts` : null %>"
force: true
---
import {Inject, Injectable} from '@nestjs/common';
import { Create<%= struct.name.pascalName %>Dto } from './dto/create-<%= struct.name.lowerKebabName %>.dto';
import { Update<%= struct.name.pascalName %>Dto } from './dto/update-<%= struct.name.lowerKebabName %>.dto';
import { <%= struct.name.pascalName %>RepositoryInterface } from 'src/repository/<%= struct.name.lowerKebabName %>.repository.interface';
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

  findAll() {
    return `This action returns all <%= struct.name.lowerCamelName %>`;
  }

  findOne(id: number) {
    return `This action returns a #${id} <%= struct.name.lowerCamelName %>`;
  }

  update(id: number, update<%= struct.name.pascalName %>Dto: Update<%= struct.name.pascalName %>Dto) {
    return `This action updates a #${id} <%= struct.name.lowerCamelName %>`;
  }

  remove(id: number) {
    return `This action removes a #${id} <%= struct.name.lowerCamelName %>`;
  }
}
