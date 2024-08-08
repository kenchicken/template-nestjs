---
to: "<%= struct.generateEnable ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/search-${struct.name.lowerKebabName}.handler.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import <%= struct.name.pascalName %>Dto from 'src/app/dto/<%= struct.name.lowerKebabName %>.dto';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';

@Injectable()
export class Search<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(condition: <%= struct.name.pascalName %>Dto) {
    return this.<%= struct.name.lowerCamelName %>Repository.getAll(condition);
  }
}
