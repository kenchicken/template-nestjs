---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/module/${struct.name.lowerKebabName}/${struct.name.lowerKebabName}.module.ts` : null %>"
force: true
---
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as Controllers from './controller';
import * as Services from './service';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';
import {<%= struct.name.pascalName %>Repository, <%= struct.name.pascalName %>ControllerGenerated} from "../../infrastructure/database/<%= struct.name.lowerKebabName %>.repository";
import {<%= struct.name.pascalName %>Controller,<%= struct.name.pascalName %>ControllerGenerated} from "./controller";

const toArray = (obj: Object ) => {
  return Object.keys( obj ).map( key => obj[key] );
}

@Module({
  imports: [TypeOrmModule.forFeature([<%= struct.name.pascalName %>Entity])],
  controllers: [<%= struct.name.pascalName %>Controller],
  providers: [
    ...toArray(Services),
    {
      provide: 'repository',
      useClass: <%= struct.name.pascalName %>Repository
    },
    {
      provide: 'repositoryGenerated',
      useClass: <%= struct.name.pascalName %>RepositoryGenerated
    }
  ],
})
export class <%= struct.name.pascalName %>Module {}
