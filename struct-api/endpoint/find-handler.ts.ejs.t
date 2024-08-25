---
to: "<%= !struct.excludeGenerateAPI.get ? `${rootDirectory}/api/src/app/endpoint/${struct.name.lowerKebabName}/service/handler/find-${struct.name.lowerKebabName}.handler.generated.ts` : null %>"
force: true
---
import { Inject, Injectable } from '@nestjs/common';
import Find<%= struct.name.pascalName %>Response from 'src/app/endpoint/<%= struct.name.lowerKebabName %>/dto/find-<%= struct.name.lowerKebabName %>.response.generated';
import { <%= struct.name.pascalName %>RepositoryInterfaceGenerated } from 'src/app/repository/<%= struct.name.lowerKebabName %>.repository.interface.generated';
import ObjectUtil from 'src/app/util/object-util';

@Injectable()
export class Find<%= struct.name.pascalName %>Handler {
  constructor(
    @Inject('<%= struct.name.lowerCamelName %>RepositoryGenerated')
    private readonly <%= struct.name.lowerCamelName %>Repository: <%= struct.name.pascalName %>RepositoryInterfaceGenerated,
  ) {}

  async exec(id: number, loginUserID: number): Promise<Find<%= struct.name.pascalName %>Response> {
    const result = await this.<%= struct.name.lowerCamelName %>Repository.get(id);
    const response = new Find<%= struct.name.pascalName %>Response();
    ObjectUtil.copyMatchingFields(result, response);
    return response;
  }
}
