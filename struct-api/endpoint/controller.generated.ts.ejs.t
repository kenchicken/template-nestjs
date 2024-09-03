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
  Patch,
  UseGuards,
} from '@nestjs/common';
import {
<%_ if (!struct.excludeGenerateAPI.create) { -%>
  Create<%= struct.name.pascalName %>Handler,
<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.update) { -%>
  Update<%= struct.name.pascalName %>Handler,
<%_ } -%>
<%_ if (!struct.excludeGenerateAPI.patch) { -%>
  Patch<%= struct.name.pascalName %>Handler,
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
import {
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
  ApiBearerAuth,
  ApiQuery
} from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
<%_ if (authCodeJwtList.length > 0) { -%>
import { AuthCodeJwtGuard } from 'src/app/endpoint/auth/guard/auth-code-jwt.guard';
<%_ } -%>
import Model<%= struct.name.pascalName %> from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/model-<%= struct.name.lowerKebabName %>';
import { Search<%= struct.name.pascalName %>Condition } from 'src/app/repository/condition/generated/search-<%= struct.name.lowerKebabName %>.condition';
import Model<%= struct.name.pascalPluralName %> from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/generated/search-<%= struct.name.lowerKebabName %>.response';

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
    type: Model<%= struct.name.pascalName %>,
  })
  create<%= struct.name.pascalName %>(@Body() request: Model<%= struct.name.pascalName %>, @Request() req) {
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
    type: Model<%= struct.name.pascalPluralName %>,
    isArray: true,
  })
  <%_ struct.fields.forEach(function (field, key) { -%>
  <%_ if (!field.relatedType) { -%>
  <%_ if (field.dataType === 'string') { -%>
  @ApiQuery({ name: '<%= field.name.lowerCamelName %>', required: false, type: String })
  <%_ } -%>
  <%_ if (field.dataType === 'number') { -%>
  @ApiQuery({ name: '<%= field.name.lowerCamelName %>', required: false, type: Number })
  <%_ } -%>
  <%_ if (field.dataType === 'time') { -%>
  @ApiQuery({ name: '<%= field.name.lowerCamelName %>', required: false, type: String })
  <%_ } -%>
  <%_ if (field.dataType === 'bool') { -%>
  @ApiQuery({ name: '<%= field.name.lowerCamelName %>', required: false, type: Boolean })
  <%_ } -%>
  <%_ } -%>
  <%_ }) -%>
  @ApiQuery({ name: 'limit', required: false, type: Number })
  @ApiQuery({ name: 'offset', required: false, type: Number })
  @ApiQuery({ name: 'orderBy', required: false, type: String })
  search<%= struct.name.pascalName %>(@Query() request: Search<%= struct.name.pascalName %>Condition, @Request() req) {
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
    type: Model<%= struct.name.pascalName %>,
  })
  get<%= struct.name.pascalName %>(@Param('id') id: number, @Request() req) {
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
    type: Model<%= struct.name.pascalName %>,
  })
  update<%= struct.name.pascalName %>(@Param('id') id: number, @Body() request: Model<%= struct.name.pascalName %>, @Request() req) {
    request.loginUserID = req.user?.userID;
    return this.update<%= struct.name.pascalName %>Handler.exec(id, request);
  }

  <%_ } -%>
  <%_ if (!struct.excludeGenerateAPI.patch) { -%>
  @Patch(':id')
  <%_ if (authCodeJwtList.includes('patch')) { -%>
  @UseGuards(AuthCodeJwtGuard)
  @ApiBearerAuth()
  <%_ } else if (authNoneList.includes('patch')) { -%>
  <%_ } else { -%>
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  <%_ } -%>
  @ApiOkResponse({
    type: Model<%= struct.name.pascalName %>,
  })
  patch<%= struct.name.pascalName %>(@Param('id') id: number, @Body() request: Model<%= struct.name.pascalName %>, @Request() req) {
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
  delete<%= struct.name.pascalName %>(@Param('id') id: number, @Request() req) {
    return this.delete<%= struct.name.pascalName %>Handler.exec(id, req.user?.userID);
  }
  <%_ } -%>
}
