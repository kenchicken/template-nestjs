---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/handler/${struct.name.lowerSnakeName}/${struct.name.lowerSnakeName}.service.ts` : null %>"
force: true
---
import {Inject, Injectable} from '@nestjs/common';
import { Create<%= struct.name.pascalName %>Dto } from './dto/create-<%= struct.name.lowerSnakeName %>.dto';
import { Update<%= struct.name.pascalName %>Dto } from './dto/update-<%= struct.name.lowerSnakeName %>.dto';
import { <%= struct.name.pascalName %>RepositoryInterface } from 'src/repository/<%= struct.name.lowerSnakeName %>.repository.interface';
import <%= struct.name.pascalName %>Entity from "../../entity/<%= struct.name.lowerSnakeName %>.entity";

@Injectable()
export class <%= struct.name.pascalName %>Service {
  constructor(
    @Inject('repository')
    private readonly <%= struct.name.lowerSnakeName %>Repository: <%= struct.name.pascalName %>RepositoryInterface,
  ) {}

  async create(create<%= struct.name.pascalName %>Dto: Create<%= struct.name.pascalName %>Dto): Promise<<%= struct.name.pascalName %>Entity> {
    const new<%= struct.name.pascalName %> = await this.<%= struct.name.lowerSnakeName %>Repository.create({
      email: create<%= struct.name.pascalName %>Dto.email,
      firstName: create<%= struct.name.pascalName %>Dto.firstName,
      lastName: create<%= struct.name.pascalName %>Dto.lastName,
      isActive: create<%= struct.name.pascalName %>Dto.isActive,
    });
    await this.<%= struct.name.lowerSnakeName %>Repository.save(new<%= struct.name.pascalName %>);
    return new<%= struct.name.pascalName %>;
  }

  findAll() {
    return `This action returns all <%= struct.name.lowerSnakeName %>`;
  }

  findOne(id: number) {
    return `This action returns a #${id} <%= struct.name.lowerSnakeName %>`;
  }

  update(id: number, update<%= struct.name.pascalName %>Dto: Update<%= struct.name.pascalName %>Dto) {
    return `This action updates a #${id} <%= struct.name.lowerSnakeName %>`;
  }

  remove(id: number) {
    return `This action removes a #${id} <%= struct.name.lowerSnakeName %>`;
  }
}
