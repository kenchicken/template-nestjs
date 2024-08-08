---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/controller/${struct.name.lowerKebabName}.controller.generated.ts` : null %>"
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
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';
import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';

@Controller('<%= struct.name.lowerKebabName %>')
@ApiTags('<%= struct.name.lowerKebabName %>')
export class <%= struct.name.pascalName %>ControllerGenerated {
  constructor(private readonly <%= struct.name.lowerCamelName %>Service: <%= struct.name.pascalName %>ServiceGenerated) {}

  @Post()
  @ApiCreatedResponse({
    type: <%= struct.name.pascalName %>Dto,
  })
  create(@Body() create<%= struct.name.pascalName %>Dto: <%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerCamelName %>Service.create(create<%= struct.name.pascalName %>Dto);
  }

  @Get()
  @ApiOkResponse({
    type: EventDto,
    isArray: true,
  })
  findAll(@Query() conditionDto: <%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerCamelName %>Service.findAll(conditionDto);
  }

  @Get(':id')
  @ApiOkResponse({
    type: EventDto,
  })
  findOne(@Param('id') id: string) {
    return this.<%= struct.name.lowerCamelName %>Service.findOneById(+id);
  }

  @Put(':id')
  @ApiOkResponse({
    type: EventDto,
  })
  update(@Param('id') id: string, @Body() update<%= struct.name.pascalName %>Dto: <%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerCamelName %>Service.update(+id, update<%= struct.name.pascalName %>Dto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.<%= struct.name.lowerCamelName %>Service.remove(+id);
  }
}
