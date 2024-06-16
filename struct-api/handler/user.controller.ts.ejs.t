---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/handler/${struct.name.lowerSnakeName}/${struct.name.lowerSnakeName}.controller.ts` : null %>"
force: true
---
import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { <%= struct.name.pascalName %>Service } from './<%= struct.name.lowerSnakeName %>.service';
import { Create<%= struct.name.pascalName %>Dto } from './dto/create-<%= struct.name.lowerSnakeName %>.dto';
import { Update<%= struct.name.pascalName %>Dto } from './dto/update-<%= struct.name.lowerSnakeName %>.dto';

@Controller('<%= struct.name.lowerSnakeName %>')
export class <%= struct.name.pascalName %>Controller {
  constructor(private readonly <%= struct.name.lowerSnakeName %>Service: <%= struct.name.pascalName %>Service) {}

  @Post()
  create(@Body() create<%= struct.name.pascalName %>Dto: Create<%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerSnakeName %>Service.create(create<%= struct.name.pascalName %>Dto);
  }

  @Get()
  findAll() {
    return this.<%= struct.name.lowerSnakeName %>Service.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.<%= struct.name.lowerSnakeName %>Service.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() update<%= struct.name.pascalName %>Dto: Update<%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerSnakeName %>Service.update(+id, update<%= struct.name.pascalName %>Dto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.<%= struct.name.lowerSnakeName %>Service.remove(+id);
  }
}
