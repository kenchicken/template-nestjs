---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/controller/${struct.name.lowerKebabName}.controller.generated.ts` : null %>"
force: true
---
import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  Query,
  Put,
} from '@nestjs/common';
import { <%= struct.name.pascalName %>ServiceGenerated } from '../service';
import { Create<%= struct.name.pascalName %>Dto } from '../dto/create-<%= struct.name.lowerKebabName %>.dto';
import { Update<%= struct.name.pascalName %>Dto } from '../dto/update-<%= struct.name.lowerKebabName %>.dto';
import { Search<%= struct.name.pascalName %>Dto } from '../dto/search-<%= struct.name.lowerKebabName %>.dto';

@Controller('<%= struct.name.lowerKebabName %>')
export class <%= struct.name.pascalName %>ControllerGenerated {
  constructor(private readonly <%= struct.name.lowerCamelName %>Service: <%= struct.name.pascalName %>ServiceGenerated) {}

  @Post()
  create(@Body() create<%= struct.name.pascalName %>Dto: Create<%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerCamelName %>Service.create(create<%= struct.name.pascalName %>Dto);
  }

  @Get()
  findAll(@Query() conditionDto: SearchUserDto) {
    return this.<%= struct.name.lowerCamelName %>Service.findAll(conditionDto);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.<%= struct.name.lowerCamelName %>Service.findOneById(+id);
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() update<%= struct.name.pascalName %>Dto: Update<%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerCamelName %>Service.update(+id, update<%= struct.name.pascalName %>Dto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.<%= struct.name.lowerCamelName %>Service.remove(+id);
  }
}
