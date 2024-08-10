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
<%_ if (!struct.excludeGenerateAPI.create) { -%>
  Create<%= struct.name.pascalName %>Handler,
<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.update) { -%>
  Update<%= struct.name.pascalName %>Handler,
<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.delete) { -%>
  Delete<%= struct.name.pascalName %>Handler,
<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.get) { -%>
  Find<%= struct.name.pascalName %>Handler,
<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.search) { -%>
  Search<%= struct.name.pascalName %>Handler,
<%_ } -%>
} from '../service';
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';
import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';

@Controller('<%= struct.name.lowerKebabName %>')
@ApiTags('<%= struct.name.lowerKebabName %>')
export class <%= struct.name.pascalName %>ControllerGenerated {
  constructor(
  <%_ if (!struct.excludeGenerateAPI.create) { -%>
    private readonly create<%= struct.name.pascalName %>Handler: Create<%= struct.name.pascalName %>Handler,
  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.update) { -%>
    private readonly update<%= struct.name.pascalName %>Handler: Update<%= struct.name.pascalName %>Handler,
  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.delete) { -%>
    private readonly delete<%= struct.name.pascalName %>Handler: Delete<%= struct.name.pascalName %>Handler,
  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.get) { -%>
    private readonly find<%= struct.name.pascalName %>Handler: Find<%= struct.name.pascalName %>Handler,
  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.search) { -%>
    private readonly search<%= struct.name.pascalName %>Handler: Search<%= struct.name.pascalName %>Handler,
  <%_ } -%>
  ) {}

  <%_ if (!struct.excludeGenerateAPI.create) { -%>
  @Post()
  @ApiCreatedResponse({
    type: <%= struct.name.pascalName %>Dto,
  })
  create(@Body() create<%= struct.name.pascalName %>Dto: <%= struct.name.pascalName %>Dto) {
    return this.create<%= struct.name.pascalName %>Handler.exec(create<%= struct.name.pascalName %>Dto);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.search) { -%>
  @Get()
  @ApiOkResponse({
    type: <%= struct.name.pascalName %>Dto,
    isArray: true,
  })
  findAll(@Query() conditionDto: <%= struct.name.pascalName %>Dto) {
    return this.search<%= struct.name.pascalName %>Handler.exec(conditionDto);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.get) { -%>
  @Get(':id')
  @ApiOkResponse({
    type: <%= struct.name.pascalName %>Dto,
  })
  findOne(@Param('id') id: number) {
    return this.find<%= struct.name.pascalName %>Handler.exec(id);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.update) { -%>
  @Put(':id')
  @ApiOkResponse({
    type: <%= struct.name.pascalName %>Dto,
  })
  update(@Param('id') id: number, @Body() update<%= struct.name.pascalName %>Dto: <%= struct.name.pascalName %>Dto) {
    return this.update<%= struct.name.pascalName %>Handler.exec(id, update<%= struct.name.pascalName %>Dto);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.delete) { -%>
  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.delete<%= struct.name.pascalName %>Handler.exec(id);
  }
  <%_ } -%>
}
