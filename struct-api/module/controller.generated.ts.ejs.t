---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/module/${struct.name.lowerKebabName}/controller/${struct.name.lowerKebabName}.controller.ts` : null %>"
force: true
---
import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { <%= struct.name.pascalName %>ServiceGenerated } from './<%= struct.name.lowerKebabName %>.service.generated';
import { Create<%= struct.name.pascalName %>Dto } from './dto/create-<%= struct.name.lowerKebabName %>.dto';
import { Update<%= struct.name.pascalName %>Dto } from './dto/update-<%= struct.name.lowerKebabName %>.dto';

@Controller('<%= struct.name.lowerKebabName %>')
export class <%= struct.name.pascalName %>Controller {
  constructor(private readonly <%= struct.name.lowerCamelName %>Service: <%= struct.name.pascalName %>ServiceGenerated) {}

  @Post()
  create(@Body() create<%= struct.name.pascalName %>Dto: Create<%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerCamelName %>Service.create(create<%= struct.name.pascalName %>Dto);
  }

  @Get()
  findAll() {
    return this.<%= struct.name.lowerCamelName %>Service.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.<%= struct.name.lowerCamelName %>Service.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() update<%= struct.name.pascalName %>Dto: Update<%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerCamelName %>Service.update(+id, update<%= struct.name.pascalName %>Dto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.<%= struct.name.lowerCamelName %>Service.remove(+id);
  }
}
