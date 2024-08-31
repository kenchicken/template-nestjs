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
  Request,
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
import { ApiCreatedResponse, ApiOkResponse, ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
<%_ if (authCodeJwtList.length > 0) { -%>
import { AuthCodeJwtGuard } from 'src/app/endpoint/auth/guard/auth-code-jwt.guard';
<%_ } -%>
import Create<%= struct.name.pascalName %>Request from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/create-<%= struct.name.lowerKebabName %>.request';
import Create<%= struct.name.pascalName %>Response from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/create-<%= struct.name.lowerKebabName %>.response';
import Update<%= struct.name.pascalName %>Request from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/update-<%= struct.name.lowerKebabName %>.request';
import Update<%= struct.name.pascalName %>Response from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/update-<%= struct.name.lowerKebabName %>.response';
import Patch<%= struct.name.pascalName %>Request from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/patch-<%= struct.name.lowerKebabName %>.request';
import Patch<%= struct.name.pascalName %>Response from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/patch-<%= struct.name.lowerKebabName %>.response';
import Find<%= struct.name.pascalName %>Response from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/find-<%= struct.name.lowerKebabName %>.response';
import { Search<%= struct.name.pascalName %>Condition } from 'src/app/repository/condition/generated/search-<%= struct.name.lowerKebabName %>.condition';
import Search<%= struct.name.pascalName %>Response from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/search-<%= struct.name.lowerKebabName %>.response';
import Delete<%= struct.name.pascalName %>Request from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/delete-<%= struct.name.lowerKebabName %>.request';

@Controller('api/v1/<%= struct.name.lowerCamelName %>')
@ApiTags('<%= struct.name.pascalName %>')
export class <%= struct.name.pascalName %>ControllerGenerated {
  constructor(
  <%_ if (!struct.excludeGenerateAPI.create) { -%>
    private readonly create<%= struct.name.pascalName %>Handler: Create<%= struct.name.pascalName %>Handler,
  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.update) { -%>
    private readonly update<%= struct.name.pascalName %>Handler: Update<%= struct.name.pascalName %>Handler,
  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.patch) { -%>
    private readonly patch<%= struct.name.pascalName %>Handler: Patch<%= struct.name.pascalName %>Handler,
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
  @ApiBearerAuth()
  <%_ } else if (authNoneList.includes('create')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  <%_ } -%>
  @ApiCreatedResponse({
    type: Create<%= struct.name.pascalName %>Response,
  })
  create(@Body() request: Create<%= struct.name.pascalName %>Request, @Request() req) {
    request.loginUserID = req.user?.userID;
    return this.create<%= struct.name.pascalName %>Handler.exec(request);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.search) { -%>
  @Get()
  <%_ if (authCodeJwtList.includes('search')) { -%>
  @UseGuards(AuthCodeJwtGuard)
  @ApiBearerAuth()
  <%_ } else if (authNoneList.includes('search')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  <%_ } -%>
  @ApiOkResponse({
    type: Search<%= struct.name.pascalName %>Response,
    isArray: true,
  })
  findAll(@Query() request: Search<%= struct.name.pascalName %>Condition, @Request() req) {
    request.loginUserID = req.user?.userID;
    return this.search<%= struct.name.pascalName %>Handler.exec(request);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.get) { -%>
  @Get(':id')
  <%_ if (authCodeJwtList.includes('find')) { -%>
  @UseGuards(AuthCodeJwtGuard)
  @ApiBearerAuth()
  <%_ } else if (authNoneList.includes('find')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  <%_ } -%>
  @ApiOkResponse({
    type: Find<%= struct.name.pascalName %>Response,
  })
  findOne(@Param('id') id: number, @Request() req) {
    return this.find<%= struct.name.pascalName %>Handler.exec(id, req.user?.userID);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.update) { -%>
  @Put(':id')
  <%_ if (authCodeJwtList.includes('update')) { -%>
  @UseGuards(AuthCodeJwtGuard)
  @ApiBearerAuth()
  <%_ } else if (authNoneList.includes('update')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  <%_ } -%>
  @ApiOkResponse({
    type: Update<%= struct.name.pascalName %>Response,
  })
  update(@Param('id') id: number, @Body() request: Update<%= struct.name.pascalName %>Request, @Request() req) {
    request.loginUserID = req.user?.userID;
    return this.update<%= struct.name.pascalName %>Handler.exec(id, request);
  }

<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.patch) { -%>
@Put(':id')
<%_ if (authCodeJwtList.includes('patch')) { -%>
@UseGuards(AuthCodeJwtGuard)
@ApiBearerAuth()
<%_ } else if (authNoneList.includes('patch')) { -%>
<%_ } else { -%>
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
<%_ } -%>
@ApiOkResponse({
type: Patch<%= struct.name.pascalName %>Response,
})
patch(@Param('id') id: number, @Body() request: Patch<%= struct.name.pascalName %>Request, @Request() req) {
request.loginUserID = req.user?.userID;
return this.patch<%= struct.name.pascalName %>Handler.exec(id, request);
}

<%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.delete) { -%>
  @Delete(':id')
  <%_ if (authCodeJwtList.includes('remove')) { -%>
  @UseGuards(AuthCodeJwtGuard)
  @ApiBearerAuth()
  <%_ } else if (authNoneList.includes('remove')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  <%_ } -%>
  delete(@Param('id') id: number, @Body() request: Delete<%= struct.name.pascalName %>Request, @Request() req) {
    request.loginUserID = req.user?.userID;
    return this.delete<%= struct.name.pascalName %>Handler.exec(id, request);
  }
  <%_ } -%>
}
