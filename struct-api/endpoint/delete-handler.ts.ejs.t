---
to: "<%= !struct.excludeGenerateAPI.delete ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/delete-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import Delete<%= struct.name.pascalName %>Request from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/delete-<%= struct.name.lowerKebabName %>.request.generated';

@Injectable()
export class Delete<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(id: number, delete<%= struct.name.pascalName %>Request: Delete<%= struct.name.pascalName %>Request): Promise<void> {
    return await this.<%= struct.name.lowerCamelName %>Repository.delete(id);
  }
}
