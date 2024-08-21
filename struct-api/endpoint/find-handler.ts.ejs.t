---
to: "<%= !struct.excludeGenerateAPI.get ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/get-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import Find<%= struct.name.pascalName %>Response from 'src/app/endpoint/${struct.name.lowerKebabName}/dto/find-<%= struct.name.lowerKebabName %>.response';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import <%= struct.name.pascalName %>Entity from 'src/app/entity/<%= struct.name.lowerKebabName %>.entity';

@Injectable()
export class Find<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(id: number): Promise<Find<%= struct.name.pascalName %>Response> {
    return await this.<%= struct.name.lowerCamelName %>Repository.get(id);
  }
}
