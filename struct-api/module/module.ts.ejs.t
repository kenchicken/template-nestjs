---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/${struct.name.lowerKebabName}.module.ts` : null %>"
force: true
---
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as Controllers from './controller';
import * as Services from './service';
<%_ project.structs.forEach(function (aStruct, key) { -%>
import <%= aStruct.name.pascalName %>Entity from 'src/app/entity/<%= aStruct.name.lowerKebabName %>.entity';
import { <%= aStruct.name.pascalName %>Repository } from '../../infrastructure/typeorm/<%= aStruct.name.lowerKebabName %>.repository';
<%_ }) -%>

const toArray = (obj: any) => {
  return Object.keys(obj).map((key) => obj[key]);
};

@Module({
  imports: [TypeOrmModule.forFeature([
<%_ project.structs.forEach(function (aStruct, key) { -%>
    <%= aStruct.name.pascalName %>Entity,
<%_ }) -%>
  ])],
  controllers: toArray(Controllers),
  providers: [
    ...toArray(Services),
<%_ project.structs.forEach(function (aStruct, key) { -%>
    {
      provide: '<%= aStruct.name.lowerCamelName %>Repository',
      useClass: <%= aStruct.name.pascalName %>Repository,
    },
    {
      provide: '<%= aStruct.name.lowerCamelName %>RepositoryGenerated',
      useClass: <%= aStruct.name.pascalName %>RepositoryGenerated,
    },
<%_ }) -%>
  ],
})
export class <%= struct.name.pascalName %>Module {}
