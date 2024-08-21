---
to: "<%= !struct.excludeGenerateAPI.delete ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/delete-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';

@Injectable()
export class Delete<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(id: number) {
    return await this.<%= struct.name.lowerCamelName %>Repository.delete(id);
  }
}
