---
to: "<%=  !struct.excludeGenerateAPI.search ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/search-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import Search<%= struct.name.pascalName %>Condition from '/src/app/repository/condition/generated/search-<%= struct.name.lowerKebabName %>.condition';
import Search<%= struct.name.pascalName %>Response from 'src/app/endpoint/${struct.name.lowerKebabName}/dto/search-<%= struct.name.lowerKebabName %>.response';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';

@Injectable()
export class Search<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(condition: Search<%= struct.name.pascalName %>Condition): Promise<Search<%= struct.name.pascalName %>Response[]> {
    return this.<%= struct.name.lowerCamelName %>Repository.getAll(condition);
  }
}
