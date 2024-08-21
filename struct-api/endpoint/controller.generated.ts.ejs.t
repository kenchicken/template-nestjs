---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/controller/${struct.name.lowerKebabName}.controller.generated.ts` : null %>"
force: true
---
<%_
const authCodeJwtList = []
const authNoneList = []
if (struct.endpoints) {
    struct.endpoints.forEach((endpoint) => {
        if (endpoint.authType === 'authCodeJwt') {
            authCodeJwtList.push(endpoint.type)
        } else if (endpoint.authType === 'none') {
          authNoneList.push(endpoint.type)
        }
    })
}
-%>
import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  Query,
  Put,
  UseGuards,
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
import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
<%_ if (authCodeJwtList.length > 0) { -%>
import { AuthCodeJwtGuard } from 'src/app/endpoint/auth/guard/auth-code-jwt.guard';
<%_ } -%>
import Create<%= struct.name.pascalName %>Request from 'src/app/endpoint/${struct.name.lowerKebabName}/dto/create-<%= struct.name.lowerKebabName %>.request';
import Create<%= struct.name.pascalName %>Response from 'src/app/endpoint/${struct.name.lowerKebabName}/dto/create-<%= struct.name.lowerKebabName %>.response';
import Create<%= struct.name.pascalName %>Request from 'src/app/endpoint/${struct.name.lowerKebabName}/dto/create-<%= struct.name.lowerKebabName %>.request';
import Create<%= struct.name.pascalName %>Response from 'src/app/endpoint/${struct.name.lowerKebabName}/dto/create-<%= struct.name.lowerKebabName %>.response';
import Find<%= struct.name.pascalName %>Response from 'src/app/endpoint/${struct.name.lowerKebabName}/dto/find-<%= struct.name.lowerKebabName %>.response';
import Search<%= struct.name.pascalName %>Condition from '/src/app/repository/condition/generated/search-${struct.name.lowerKebabName}.condition';
import Search<%= struct.name.pascalName %>Response from 'src/app/endpoint/${struct.name.lowerKebabName}/dto/search-<%= struct.name.lowerKebabName %>.response';

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
  <%_ if (authCodeJwtList.includes('create')) { -%>
  @UseGuards(AuthCodeJwtGuard)
  <%_ } else if (authNoneList.includes('create')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  <%_ } -%>
  @ApiCreatedResponse({
    type: <%= struct.name.pascalName %>Dto,
  })
  create(@Body() create<%= struct.name.pascalName %>Request: <%= struct.name.pascalName %>Request) {
    return this.create<%= struct.name.pascalName %>Handler.exec(create<%= struct.name.pascalName %>Request);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.search) { -%>
  @Get()
  <%_ if (authCodeJwtList.includes('search')) { -%>
  @UseGuards(AuthCodeJwtGuard)
  <%_ } else if (authNoneList.includes('search')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  <%_ } -%>
  @ApiOkResponse({
    type: Search<%= struct.name.pascalName %>Response,
    isArray: true,
  })
  findAll(@Query() search<%= struct.name.pascalName %>Condition: Search<%= struct.name.pascalName %>Request) {
    return this.search<%= struct.name.pascalName %>Handler.exec(conditionDto);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.get) { -%>
  @Get(':id')
  <%_ if (authCodeJwtList.includes('find')) { -%>
  @UseGuards(AuthCodeJwtGuard)
  <%_ } else if (authNoneList.includes('find')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  <%_ } -%>
  @ApiOkResponse({
    type: Find<%= struct.name.pascalName %>Response,
  })
  findOne(@Param('id') id: number) {
    return this.find<%= struct.name.pascalName %>Handler.exec(id);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.update) { -%>
  @Put(':id')
  <%_ if (authCodeJwtList.includes('update')) { -%>
  @UseGuards(AuthCodeJwtGuard)
  <%_ } else if (authNoneList.includes('update')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  <%_ } -%>
  @ApiOkResponse({
    type: <%= struct.name.pascalName %>Dto,
  })
  update(@Param('id') id: number, @Body() update<%= struct.name.pascalName %>Request: <%= struct.name.pascalName %>Request) {
    return this.update<%= struct.name.pascalName %>Handler.exec(id, update<%= struct.name.pascalName %>Request);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.delete) { -%>
  @Delete(':id')
  <%_ if (authCodeJwtList.includes('remove')) { -%>
  @UseGuards(AuthCodeJwtGuard)
  <%_ } else if (authNoneList.includes('remove')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  <%_ } -%>
  remove(@Param('id') id: number) {
    return this.delete<%= struct.name.pascalName %>Handler.exec(id);
  }
  <%_ } -%>
}
