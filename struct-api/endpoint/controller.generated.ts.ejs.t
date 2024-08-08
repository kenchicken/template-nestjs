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
import {
  Create<%= struct.name.pascalName %>Handler,
  Update<%= struct.name.pascalName %>Handler,
  Delete<%= struct.name.pascalName %>Handler,
  Get<%= struct.name.pascalName %>Handler,
  Search<%= struct.name.pascalName %>Handler,
} from '../service';
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';
import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';

@Controller('<%= struct.name.lowerKebabName %>')
@ApiTags('<%= struct.name.lowerKebabName %>')
export class <%= struct.name.pascalName %>ControllerGenerated {
  constructor(private readonly create<%= struct.name.pascalName %>Handler: Create<%= struct.name.pascalName %>Handler) {}
  constructor(private readonly update<%= struct.name.pascalName %>Handler: Update<%= struct.name.pascalName %>Handler) {}
  constructor(private readonly delete<%= struct.name.pascalName %>Handler: Delete<%= struct.name.pascalName %>Handler) {}
  constructor(private readonly get<%= struct.name.pascalName %>Handler: Get<%= struct.name.pascalName %>Handler) {}
  constructor(private readonly search<%= struct.name.pascalName %>Handler: Search<%= struct.name.pascalName %>Handler) {}

  @Post()
  @ApiCreatedResponse({
    type: <%= struct.name.pascalName %>Dto,
  })
  create(@Body() create<%= struct.name.pascalName %>Dto: <%= struct.name.pascalName %>Dto) {
    return this.create<%= struct.name.pascalName %>Handler.exec(create<%= struct.name.pascalName %>Dto);
  }

  @Get()
  @ApiOkResponse({
    type: EventDto,
    isArray: true,
  })
  findAll(@Query() conditionDto: <%= struct.name.pascalName %>Dto) {
    return this.search<%= struct.name.pascalName %>Handler.exec(conditionDto);
  }

  @Get(':id')
  @ApiOkResponse({
    type: EventDto,
  })
  findOne(@Param('id') id: string) {
    return this.get<%= struct.name.pascalName %>Handler.exec.findOneById(+id);
  }

  @Put(':id')
  @ApiOkResponse({
    type: EventDto,
  })
  update(@Param('id') id: string, @Body() update<%= struct.name.pascalName %>Dto: <%= struct.name.pascalName %>Dto) {
    return this.this.update<%= struct.name.pascalName %>Handler.exec(id, update<%= struct.name.pascalName %>Dto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.delete<%= struct.name.pascalName %>Handler.exec(+id);
  }
}
